#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef __DMC__
  #define strcasecmp stricmp
#endif
unsigned char *mem, *precalc;
unsigned char inibit= 0, tzx= 0, channel_type= 1, checksum;
FILE *fi, *fo;
int i, j, k, ind= 0;
unsigned short length, flag, outbyte= 1, frequency= 44100, pilotts, pilotpulses;

void outbits( short val ){
  if( tzx )
    for ( i= 0; i<val; i++ )
      if( outbyte>0xff )
        precalc[ind++]= outbyte&0xff,
        outbyte= 2 | inibit;
      else
        outbyte<<= 1,
        outbyte|= inibit;
  else
    for ( i= 0; i<val; i++ ){
      precalc[ind++]= inibit ? 0xc0 : 0x40;
      if( channel_type==2 )
        precalc[ind++]= inibit ? 0xc0 : 0x40;
      else if( channel_type==6 )
        precalc[ind++]= inibit ? 0x40 : 0xc0;
    }
  if( ind>0xff000 )
    fwrite( precalc, 1, ind, fo ),
    ind= 0;
  inibit^= 1;
}

char char2hex(char value, char * name){
  if( value<'0' || value>'f' || value<'A' && value>'9' || value<'a' && value>'F' )
    printf("\nInvalid character %c or '%s' not exists\n", value, name),
    exit(-1);
  return value>'9' ? 9+(value&7) : value-'0';
}

int parseHex(char * name, int index){
  int flen= strlen(name);
  if( name[0]=='\'' )
    for ( i= 1; i<11 && name[i]!='\''; ++i )
      mem[i+6]= name[i];
  else if( ~flen & 1 ){
    flen>>= 1;
    flen>10 && index==7 && (flen= 10);
    for ( i= 0; i < flen; i++ )
      mem[i+index]= char2hex(name[i<<1|1], name) | char2hex(name[i<<1], name) << 4;
    ++i;
  }
  while( ++i<12 )
    mem[i+5]= ' ';
  return flen;
}

int main(int argc, char* argv[]){
  mem= (unsigned char *) malloc (0x20000);
  if( argc==1 )
    printf("\nleches v0.01, an ultra load block generator by Antonio Villena, 18 Feb 2013\n\n"),
    printf("  leches <srate> <channel_type> <ofile> <flag> <pilot_ms> <pause_ms> <ifile>\n\n"),
    printf("  <srate>         Sample rate, 44100 or 48000. Default is 44100\n"),
    printf("  <channel_type>  Possible values are: mono (default), stereo or stereoinv\n"),
    printf("  <ofile>         Output file, between TZX or WAV file\n"),
    printf("  <flag>          Flag byte, 00 for header, ff or another for data blocks\n"),
    printf("  <pilot_ms>      Duration of pilot in milliseconds\n"),
    printf("  <pause_ms>      Duration of pause after block in milliseconds\n"),
    printf("  <ifile>         Hexadecimal string or filename as data origin of that block\n\n"),
    exit(0);
  if( argc!=8 )
    printf("\nInvalid number of parameters\n"),
    exit(-1);
  frequency= atoi(argv[1]);
  if( frequency!=44100 && frequency!=48000 )
    printf("\nInvalid sample rate: %d\n", frequency),
    exit(-1);
  if( !strcasecmp(argv[2], "mono") )
    channel_type= 1;
  else if( !strcasecmp(argv[2], "stereo") )
    channel_type= 2;
  else if( !strcasecmp(argv[2], "stereoinv") )
    channel_type= 6;
  else
    printf("\nInvalid argument name: %s\n", argv[2]),
    exit(-1);
  fo= fopen(argv[3], "wb+");
  if( !fo )
    printf("\nCannot create output file: %s\n", argv[3]),
    exit(-1);
  precalc= (unsigned char *) malloc (0x200000);
  if( !strcasecmp((char *)strchr(argv[3], '.'), ".tzx" ) )
    ++tzx;
  else if( !strcasecmp((char *)strchr(argv[3], '.'), ".wav" ) ){
    memset(mem, 0, 44);
    memset(precalc, 128, 0x200000);
    *(int*)mem= 0x46464952;
    *(int*)(mem+8)= 0x45564157;
    *(int*)(mem+12)= 0x20746d66;
    *(char*)(mem+16)= 0x10;
    *(char*)(mem+20)= 0x01;
    *(char*)(mem+22)= *(char*)(mem+32)= channel_type&3;
    *(short*)(mem+24)= frequency;
    *(int*)(mem+28)= frequency*(channel_type&3);
    *(char*)(mem+34)= 8;
    *(int*)(mem+36)= 0x61746164;
    fwrite(mem, 1, 44, fo);
  }
  else
    printf("Output format not allowed, use only TZX or WAV\n"),
    exit(-1);
  pilotts= frequency==48000 ? 875 : 952;
  pilotpulses= atof(argv[5])*3500/pilotts+0.5;
  pilotpulses&1 || ++pilotpulses;
  fi= fopen(argv[7], "rb");
  if( fi )
    length= fread(mem, 1, 0x20000, fi);
  else
    length= parseHex(argv[7], 0);
  for ( checksum= i= 0; i<length; i++ )
    checksum^= mem[i];
  if( tzx )
    fprintf( fo, "ZXTape!" ),
    *(int*)precalc= 0xa011a,
    precalc[3]= 0x12,
    *(short*)(precalc+4)= pilotts,
    *(short*)(precalc+6)= pilotpulses,
    precalc[8]= 0x15,
    *(short*)(precalc+9)= frequency==48000 ? 73 : 79,
    *(short*)(precalc+11)= atof(argv[6]),
    ind= 17;
  else
    while( pilotpulses-- )
      outbits( 12 );
  outbits( 28 );
  pilotpulses= 6;
  while( pilotpulses-- )
    outbits( 12 );
  outbits( 2 );
  outbits( frequency==48000 ? 4 : 8 );
  flag= strtol(argv[4], NULL, 16) | checksum<<8;
  for ( j= 0; j<16; j++, flag<<= 1 )
    outbits( k= flag&0x8000 ? 4 : 8 ),
    outbits( k );
  outbits( 2 );
  outbits( 3 );
  --mem;
  while( length-- )
    outbits( 1+(*++mem  & 3) ),
    outbits( 1+(*mem>>2 & 3) ),
    outbits( 1+(*mem>>4 & 3) ),
    outbits( 1+(*mem>>6    ) );
  outbits( 1 );
  outbits( frequency==48000 ? 22 : 11 );
  outbits( 1 );
  outbits( 1 );
  if( tzx ){
    for ( j= 8; outbyte<0x100; outbyte<<= 1, --j );
    precalc[ind++]= outbyte;
    fwrite( precalc, 1, ind, fo );
    i= j | (ftell(fo)-24)<<8;
    fseek(fo, 20, SEEK_SET);
    fwrite(&i, 4, 1, fo);
  }
  else
    fwrite( precalc, 1, ind, fo ),
    fwrite( precalc+0x100000, 1, frequency*(channel_type&3)*atof(argv[6])/1000, fo),
    i= ftell(fo)-8,
    fseek(fo, 4, SEEK_SET),
    fwrite(&i, 4, 1, fo),
    i-= 36,
    fseek(fo, 40, SEEK_SET),
    fwrite(&i, 4, 1, fo);
  fclose(fi);
  fclose(fo);
  printf("\nFile generated successfully\n");
}