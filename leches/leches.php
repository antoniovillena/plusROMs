<?$ram=array("ramsp"=>"  CargLechesJ   J ������7�9�!�\ ���>�P�2���p ���z(�2���2��\015 )8�;a.��p ���p ��%)8��!� ]2��!�]��! [>�4�x��  ͝]�0��q �! �)\015 ��s4�rh��#�����͝]8��͝]0��a���{]���0\015(\015 (͏]{�O�{]��bk�B��������i�V ͏]��n4�fh	DM��  �͝]�����~#��          0\$`   CPA!\"1�]� ��c>���y!.X!(g�\"�D��-b\015U!��\�a�e'�U[Z.̥Y�^�K!�=6�T��r�V�	�+\015˒�� @�>��e���f�Y'���DM���>��[�&���bk-6 ���_X   #XjZv4Efw����3DUgwx��\"3� i�\015�4,��>� �}���1V�>��\015D�3y(^`������6�� �}��Y��Vs��BK���h<\015�V������<��@�+�i�}���}��{�& 
}��֥0	 ��\D� s�h<�`�0� ��hyW��k�6 O�K �{�`�2��j ����7�}�Z@G�Ю���j�]�< �o\$=����>��h�e���=@��Ձ�{NX��[4K�:��R�b����@�� ��\$@�� A\" 
G���w��v�p�9.�k�����qb�S����xi�]wǨ��~�_oF�}�Ox�%���cx4���0:?��4�# ��؃�| j����3��h��e�=��	�Ö2�@��e���T��3�H�O�6XM��&M|�|���~�����7 w�(&��wO��* �m�0��*(S\015=@ng;�y,ù;2��Ӽ
��\$u�����9����2JO�!��!��3˵<�&3�+a�ׯ~�o>�&�V~1 ���i�(�&7��p�m8��s�B'�w\"r4eٴ(�CYJ���X��7;\015��`k�PXk��<O���Ĉ� y����7��H��`TA\u�j0����Y�s6�8S4�#f`?�:�:�=�2��q9���}�� �o
���ǅ:?�;�9�T�O�r�l;�m��������Ϯm��\"��i�;�@�զ�3P8� �˜5JT0��@_.rd�8���; C��3��\$��ϯ��<_�\"~ɦ��D)GQ�8UGfRjO^-���;�=|!� 9p����53�G�4
�Q0�+��D4K�#��@�7��f�Ƹ<T��M,>A�M-c%���8��@.�E �X{btO�\"s��	��.n�	����%@d�rǸ��!�#K�&nȓ��@g2��|�<Ê<!�����6���:G��@���   ","ramen"=>"  CargLechesJ   J ������7�9�!�\ ���>�P�2���p ���z(�2��2�\015 )8�;a.��p ��p �%)8��!/� ]��!�]��! [>�4�x��  ͝]�0��q �! �)\015 ��s4�rh��#�����͝]8��͝]0��a���{]���0\015(\015 (͏]{�O�{]��bk�B��������i�V ͏]��n4�fh	DM��  �͝]�����~#��          0\$`   CPA!\"1�]� ��c>���y!.X!(g�\"�D��-b\015U!��\�a�e'�U[Z.̥Y�^�K!�=6�T��r�V�	�+\015˒�� @�>��e���f�Y'���DM���>��[�&���bk-6 ���_X   \$XZjv3EVw���+3DUgwx��\"3� Y�\0154 ����t��1V��>���9�ye̪ 3Z�6T��	�Aǁ��Vs��BK���h<\015���hi���<o���j���	:��C����֥0	 +��� 4�AП ~�(� 9�:.`sֳ6��` U.��2�� �B7 ]:. ��\p���]�w} 8 u�\$=����>��h�e���:�5����bX��[4K�:B]��}���P� �*�H�p� � �\$AE�p
�� ��-���9�5q�����qbS�����xi]y ����_�oF�}|Ox%Q@�`�4 �Ń:�4~, �1�����3 ��_�=�	�Ö�2�c��=R� ���վ�6���ո\0158s���s��k����7 ����b-�<
�* ���0���T(�\015z���v\015�y,ù;eYA�
yߠ\$��&!���9����2JO�!��!��C˵<�&3`{a�ׯ~�o>�&�V~1 ���i�(�&7��p�m8��s�B'�w\"r4eٴ(�CYJ���X��A;\015��`k�PXk��<G����� ��g��7 !�c@�=D��Z;j0�pw+��S�6	�S4��6f ��G�:�G�2��cq�97�o�����\015�_�؆��:'��9�T�O�[;��z��� ���OaZ��<\"���\015�;�@/�զ�3x8���xj��0�؀wa���x�݇��;gv3��	n����<#k�\"o�}:�n�B�u��VGe&�^�����;��|!� 9�N���?G�4 ��S�����hX����7�7��̀�q<Ty)�MX>���Z�%���8��@.
� X	6b�5�D���.�n��\015ILJ@�r�q��DrF��&ݑ'H��eB!���<Ê<!���N��l#���:G+\"5��� ");
function outbits($val){
  global $inibit;
  for($i= 0; $i<$val; $i++)
    outbit($inibit);
  $inibit^= 1;
}
function outbits_double($val){
  outbits($val);
  outbits($val);
}
function outbit($val){
  global $bytes;
//  $bytes.= $val ? '@' : '�';
  $bytes.= $val ? ' �' : '� ';
}
function pilot($val, $samples= 6){
  global $mhigh;
  while( $val-- )
    outbits_double( $samples << $mhigh );
}
function loadconf($b27){
  global $mhigh;
  outbits( 6 << $mhigh );
  outbits( 14 << $mhigh );
  pilot( 3 );
  outbits_double(1 << $mhigh);
  $c27= 27;
  while( $c27-- ){
    if (($c27==26 || $c27==10) && $mhigh){
      outbits( $b27&0x4000000 ? 4 : 8 );
      outbits( $b27&0x4000000 ? 5 : 9 );
    }
    else
      outbits_double( ($b27&0x4000000 ? 2 : 4) << $mhigh );
    $b27<<= 1;
  }
  outbits(1 << $mhigh);
  outbits((1 << $mhigh)+1);
}
$tabla1= array( array(1,2,2,3), array(2,2,3,3), array(2,3,3,4), array(3,3,4,4),
                array(1,2,3,4), array(2,3,4,5), array(2,3,4,5), array(3,4,5,6), array(1,1,2,2));
$tabla2= array( array(1,1,2,2), array(1,2,2,3), array(2,2,3,3), array(2,3,3,4),
                array(1,2,3,4), array(1,2,3,4), array(2,3,4,5), array(2,3,4,5), array(1,2,2,3));
$byvel= array(  array(0x7b, 0x6f, 0x60, 0x51, 0x00, 0x71, 0x62, 0x53, 0x62),
                array(0x3a, 0x2b, 0x1f, 0x10, 0x06, 0x77, 0x6b, 0x5c, 0x6b));
$termin=array(  array( 14, 15, 16, 17, 23, 24, 25, 26, 12),
                array( 11, 12, 13, 14, 24, 25, 26, 27, 8));
$argc==1 && die(
  "\nCargandoLeches WAV generator v0.1 09-02-2012 Antonio Villena, GPLv3 license\n\n".
  "  leches file.tap [rom|ramsp|ramen] [Speed] [Sample Rate] [Polarity] [check|nocheck] [Offset]\n".
  "  leches file.sna [rom|ramsp|ramen] [Speed] [Sample Rate] [Polarity] [Address Patch] [Offset]\n\n".
  "-rom|ramsp|ramen: rom=Normal ultraload, ramsp=+2A/+3 with Spanish ROM, ramen=idem but English ROM\n".
  "-Speed:       A number between 0 and 7. [0..3] for Safer and [4..7] for Reckless. Lower is faster\n".
  "-Sample Rate: In Khz and rounded (22, 24, 44 or 48). For 22050, 24000, 44100 and 48000Hz\n".
  "-Polarity:    0 or 1. If 1 the WAV signal is inverted. Same results if the signal is balanced\n".
  "-check|nocheck: if check you can show the tape loading error as in standard ROM routine\n".
  "-Offset:      -2,-1,0,1 or 2. Fine grain adjust for symbol offset. Change if you see loading errors\n".
  "-Address Patch: Address used in SNA for storing the register. Must be unused in the game\n\n".
  "Only file is mandatory. Default values for the rest of parameters are: rom, 0 (Speed), 44 (Sample   ".
  "Rate), 0 (Polarity), check, 0 (Offset) and 5780 (Address Patch)\n");
file_exists($argv[1]) || die ("\n  Error: File not exists\n");
$velo= isset($argv[3]) ? $argv[3] : 3;
$mlow= $argv[4]==24 || $argv[4]==48 ? 1 : 0;
$mhigh= $argv[4]==22 || $argv[4]==24 ? 0 : 1;
if(!$mhigh)
  $velo= 8;
$refconf= isset($argv[7])
    ? ($byvel[$mlow][$velo]&128)+($byvel[$mlow][$velo]+3*hexdec($argv[7])&127)
    : ($velo==8?6:$velo) | $mlow<<3 | 0x1f<<4;
$srate= array(array(22050,24000),array(44100,48000));
$inibit= $argv[5]==1 ? 1 : 0;
$st= array();
for($i= 0; $i<256; $i++){
  $val= $i >> 6;
  outbits($tabla1[8-2*$mhigh][$val]);
  outbits($tabla2[8-2*$mhigh][$val]);
  $val= $i >> 4 & 3;
  outbits($tabla1[8-2*$mhigh][$val]);
  outbits($tabla2[8-2*$mhigh][$val]);
  $val= $i  >> 2 & 3;
  outbits($tabla1[8-2*$mhigh][$val]);
  outbits($tabla2[8-2*$mhigh][$val]);
  $val= $i  & 3;
  outbits($tabla1[8-2*$mhigh][$val]);
  outbits($tabla2[8-2*$mhigh][$val]);
  $st[$i]= $bytes;
  $bytes= '';
}
$noprint || print("\nGenerating WAV...");
if( $argv[2]=='ramen' || $argv[2]=='ramsp' ){
  $in= $ram[$argv[2]];
  $in[68]= chr(13+$mlow);
  $in[77]= chr(192|$mlow<<3);
  $in[94]= chr(($argv[2]=='ramsp'?208:244)^11*$mlow);
  pilot( 1500, 14 );
  outbits_double( 4 << $mhigh );
  for( $i= 0; $i<19; $i++ )
    for( $j= 0; $j<8; $j++ )
      outbits_double( (ord($in[$i])<<$j & 0x80 ? 10 : 5 ) << $mhigh );
  pilot( 1500, 14 );
  outbits_double( 4 << $mhigh );
  for( $i= 19; $i<95; $i++ )
    for( $j= 0; $j<8; $j++ )
      outbits_double( (ord($in[$i])<<$j & 0x80 ? 10 : 5 ) << $mhigh );
  pilot( 6, 14 );
  outbits( 14 << $mhigh );
  outbits( 28 << $mhigh );
  $i= strlen($in);
  while( $i>95 )
    $bytes.= $st[ord($in[--$i])];
  outbits_double(4 << $mhigh);
  pilot( 1800 );
}
$tbytes= $bytes;
$bytes= '';
for($i= 0; $i<256; $i++){
  $val= $i >> 6;
  outbits($tabla1[$velo][$val]);
  outbits($tabla2[$velo][$val]);
  $val= $i >> 4 & 3;
  outbits($tabla1[$velo][$val]);
  outbits($tabla2[$velo][$val]);
  $val= $i  >> 2 & 3;
  outbits($tabla1[$velo][$val]);
  outbits($tabla2[$velo][$val]);
  $val= $i  & 3;
  outbits($tabla1[$velo][$val]);
  outbits($tabla2[$velo][$val]);
  $st[$i]= $bytes;
  $bytes= '';
}
$bytes= $tbytes;
$sna= file_get_contents($argv[1]);
if( strtolower(substr($argv[1],-3))=='tap' ){
  $check= $argv[6]=='nocheck' ? 0 : 1;
  $long= strlen($sna);
  $lastbl= $pos= 0;
  while($pos<$long){
    $len= ord($sna[$pos])|ord($sna[$pos+1])<<8;
    pilot( $lastbl ? 2000+700 : 200+700 );
    loadconf( $refconf
            | 1<<9                            // bit snapshot
            | $check<<10                      // eludo checksum
            | ord($sna[$pos+2])<<11           // byte flag
            | ord($sna[$pos+$len+1])<<19);    // checksum
    for($i= 2; $i<$len; $i++)
      $bytes.= $st[ord($sna[$pos+1+$i])];
    outbits($termin[$mlow][$velo]>>1);
    outbits($termin[$mlow][$velo]-($termin[$mlow][$velo]>>1));
    outbits_double(1 << $mhigh);
    $lastbl= ord($sna[$pos+2]);
    $pos+= $len+2;
  }
}
else{
  strtolower(substr($argv[1],-3))=='sna' || die ("\n  Invalid file: Must be TAP or SNA\n");
  $r= ord($sna[20]);
  $r= (($r&127)-5)&127 | $r&128;
  $parche= isset($argv[6]) ? hexdec($argv[6]) : 0x5780;
  if( strlen($sna)==49179 ){
    $pos= 25;
    $long= 49152+27;
    $sp= ord($sna[23]) | ord($sna[24])<<8;
    $regs=  substr($sna, 0xbffe-0x3fe5, 4).         // stack padding
            substr($sna, 5, 2).                     // BC'
            substr($sna, 3, 2).                     // DE'
            substr($sna, 1, 2).                     // HL'
            substr($sna, 7, 2).                     // AF'
            substr($sna, 13, 2).                    // BC
            substr($sna, 11, 2).                    // DE
            $sna[0].chr($r).                        // IR
            substr($sna, 17, 2).                    // IX
            substr($sna, 15, 2).                    // IY
            chr(ord($sna[25])>>1                    // IM
              | ord($sna[19])<<7                    // IFF1
              | ord($sna[26])<<1).                  // Border
            substr($sna, 21, 2).                    // AF
            chr(0x21) . substr($sna, 9, 2).         // HL
            chr(0x31) . pack('v', $sp+2).           // SP
            chr(0xc3) . substr($sna, $sp-0x3fe5, 2);// PC
    $sna=   substr($sna, 0, 0xbffe-0x3fe5).
            pack('vv', 0x3b88, $parche).
            substr($sna, 0xc002-0x3fe5);
    $sna=   substr($sna, 0, 25).
            pack('v', 0x3c42).                      // posiciones 3ffe-3fff de la ROM
            substr($sna, 27, $parche-0x4000).
            $regs.
            substr($sna, $parche+strlen($regs)-0x3fe5);
    pilot( 200+700 );
    loadconf( $refconf
            | 0<<9                            // bit snapshot activado
            | 1<<10                           // bit checksum desactivado
            | 0<<11                           // byte flag
            | 0x3f<<19);                      // start high byte
    while($pos<$long)
      $bytes.= $st[ord($sna[$pos++])];
    outbits($termin[$mlow][$velo]>>1);
    outbits($termin[$mlow][$velo]-($termin[$mlow][$velo]>>1));
    outbits_double(1 << $mhigh);
  }
  else{
    strlen($sna)==131103 || die ("\n  Invalid length for SNA file: Must be 49179 or 131103\n");
    $page[5]= substr($sna, 27, 0x4000);
    $page[2]= substr($sna, 0x401b, 0x4000);
    $last= ord($sna[0xc01d])&7;
    $page[$last]= substr($sna, 0x801b, 0x4000);
    for($i= 0; $i<8; $i++)
      if(($last!=$i)&&($i!=2)&&($i!=5))
        $page[$i]= substr($sna, 0xc01f+$next++*0x4000, 0x4000);
    $regs=  substr($page[2], 0x3ffe).                 // stack padding
            substr($page[7], 0, 2).                   // stack padding
            chr(ord($sna[0xc01d])|0x10).              // last byte 7FFD
            substr($sna, 5, 2).                       // BC'
            substr($sna, 3, 2).                       // DE'
            substr($sna, 1, 2).                       // HL'
            substr($sna, 7, 2).                       // AF'
            substr($sna, 13, 2).                      // BC
            substr($sna, 11, 2).                      // DE
            $sna[0].chr($r).                          // IR
            substr($sna, 17, 2).                      // IX
            substr($sna, 15, 2).                      // IY
            chr(ord($sna[25])>>1                      // IM
              | ord($sna[19])<<7                      // IFF1
              | ord($sna[26])<<1).                    // Border
            substr($sna, 21, 2).                      // AF
            chr(0x21) . substr($sna, 9, 2).           // HL
            chr(0x31) . substr($sna, 23, 2).          // SP
            ( ord($sna[0xc01d])&0x10
                ? ''
                : chr(0x01) . chr(0xfd) . chr(0x7f).  // LD BC,7FFD
                  chr(0x3e) . $sna[0xc01d].           // LD A,last byte 7FFD
                  chr(0xed) . chr(0x79).              // OUT (C),A
                  chr(0x01) . substr($sna, 13, 2).    // restore BC
                  chr(0x3e) . $sna[0xc01d]).          // restore A
            chr(0xc3) . substr($sna, 0xc01b, 2);      // PC
    if($parche<0x8000)
      $page[5]= substr($page[5], 0, $parche-0x4000).
                $regs.
                substr($page[5], $parche+strlen($regs)-0x4000);
    else
      $page[2]= substr($page[2], 0, $parche-0x8000).
                $regs.
                substr($page[2], $parche+strlen($regs)-0x8000);
    $page[2]= substr($page[2], 0, 0x3ffe).
              pack('v', 0x3ae6);
    $page[7]= pack('v', $parche).
              substr($page[7], 2);
    pilot( 200+700 );
    loadconf( $refconf
            | 0<<9                            // bit snapshot activado
            | 1<<10                           // bit checksum desactivado
            | 0<<11                           // byte flag
            | 0xbf<<19);                      // start high byte
    $page[0]= pack('v', 0x3ae6).$page[0];
    for($j= 0; $j<0x4002; $j++)
      $bytes.= $st[ord($page[0][$j])];
    outbits($termin[$mlow][$velo]>>1);
    outbits($termin[$mlow][$velo]-($termin[$mlow][$velo]>>1));
    outbits_double(1 << $mhigh);
    for($i= 1; $i<8; $i++){
      for($j= 0; $j<0x4000; $j++)
        $bytes.= $st[ord($page[$i][$j])];
      outbits($termin[$mlow][$velo]>>1);
      outbits($termin[$mlow][$velo]-($termin[$mlow][$velo]>>1));
      outbits_double(1 << $mhigh);
    }
  }
}
pilot( 700 );
$longi= strlen($bytes);
$noprint || print("Done\n");
$chan= 2;
$output=  'RIFF'.pack('L', $longi+36).'WAVEfmt '.pack('L', 16).pack('v', 1).pack('v', $chan).
          pack('L', $srate[$mhigh][$mlow]).pack('L', $srate[$mhigh][$mlow]*$chan).
          pack('v', $chan).pack('v', 8).'data'.pack('L', $longi).$bytes;
$noprint || file_put_contents(substr($argv[1],0,-4).'.wav', $output);