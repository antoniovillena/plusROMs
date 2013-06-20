library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lec4 is port(
    clk7    : in  std_logic;
--    reset   : in  std_logic;
    sync    : out std_logic;
    r       : out std_logic;
    g       : out std_logic;
    b       : out std_logic;
    i       : out std_logic;
    clkps2  : in  std_logic;
    dataps2 : in  std_logic);
end lec4;

architecture behavioral of lec4 is

  signal  hcount  : unsigned  (8 downto 0):= (others => '0');
  signal  vcount  : unsigned  (8 downto 0):= (others => '0');
  signal  vid     : std_logic;
  signal  viddel  : std_logic;
  signal  cbis1   : std_logic;
  signal  cbis2   : std_logic;
  signal  orbis2  : std_logic;
  signal  at2clk  : std_logic;
  signal  ccount  : unsigned  (4 downto 0):= (others => '0');
  signal  flash   : unsigned  (4 downto 0):= (others => '0');
  signal  at1     : std_logic_vector (7 downto 0);
  signal  at2     : std_logic_vector (7 downto 0);
  signal  da1     : std_logic_vector (7 downto 0);
  signal  da2     : std_logic_vector (7 downto 0);
  signal  addrv   : std_logic_vector (13 downto 0);
  signal  wrv     : std_logic;
  signal  clkcpu  : std_logic;
  signal  abus    : std_logic_vector (15 downto 0);
  signal  dbus    : std_logic_vector (7 downto 0);
  signal  din_rom : std_logic_vector (7 downto 0);
  signal  din_ram : std_logic_vector (7 downto 0);
  signal  mreq_n  : std_logic;
  signal  iorq_n  : std_logic;
  signal  wr_n    : std_logic;
  signal  rd_n    : std_logic;
  signal  int_n   : std_logic;
--  signal  kbcol   : std_logic_vector (4 downto 0);

  component ram is port(
      clk   : in  std_logic;
      wr    : in  std_logic;
      addr  : in  std_logic_vector(13 downto 0);
      din   : in  std_logic_vector( 7 downto 0);
      dout  : out std_logic_vector( 7 downto 0));
  end component;

  component rom is port(
      clk   : in  std_logic;
      addr  : in  std_logic_vector(13 downto 0);
      dout  : out std_logic_vector(7 downto 0));
  end component;

  component T80a is port(
      RESET_n : in std_logic;
      CLK_n   : in std_logic;
      WAIT_n  : in std_logic;
      INT_n   : in std_logic;
      NMI_n   : in std_logic;
      BUSRQ_n : in std_logic;
      M1_n    : out std_logic;
      MREQ_n  : out std_logic;
      IORQ_n  : out std_logic;
      RD_n    : out std_logic;
      WR_n    : out std_logic;
      RFSH_n  : out std_logic;
      HALT_n  : out std_logic;
      BUSAK_n : out std_logic;
      A       : out std_logic_vector(15 downto 0);
      D       : inout std_logic_vector(7 downto 0));
  end component;

begin

  ram_inst: ram port map (
    clk   => clk7,
    wr    => wrv,
    addr  => addrv,
    din   => dbus,
    dout  => din_ram);

  rom_inst: rom port map (
    clk   => clk7,
    addr  => abus(13 downto 0),
    dout  => din_rom);

  T80a_inst: T80a port map (
<<<<<<< .mine
    RESET_n => '1',
=======
--    RESET_n => reset,
    RESET_n => '1',
>>>>>>> .r396
    CLK_n   => clkcpu,
    WAIT_n  => '1',
    INT_n   => int_n,
    NMI_n   => '1',
    BUSRQ_n => '1',
    MREQ_n  => mreq_n,
    IORQ_n  => iorq_n,
    RD_n    => rd_n,
    WR_n    => wr_n,
    A       => abus,
    D       => dbus);

  process (clk7)
  begin
    if falling_edge( clk7 ) then
      if hcount=447 then
        hcount <= (others => '0');
        if vcount=311 then
          vcount <= (others => '0');
          flash <= flash + 1;
        else
          vcount <= vcount + 1;
        end if;
      else
        hcount <= hcount + 1;
      end if;

      int_n <= '1';
      if vcount=248 and hcount<32 then
        int_n <= '0';
      end if;

      da2 <= da2(6 downto 0) & '0';
      if at2clk='0' then
        ccount <= hcount(7 downto 3);
        if viddel='0' then
          da2 <= da1;
        end if;
      end if;

<<<<<<< .mine
      if vid='0' then
        if (hcount(1) and (hcount(2) xor hcount(3)))='1' then
          da1 <= din_ram;
        end if;
        if (not hcount(1) and hcount(3))='1' then
          at1 <= din_ram;
        end if;
      end if;
=======
      cbis1 <= vid nor (hcount(3) and hcount(2));
>>>>>>> .r396

      cbis1 <= vid nor (hcount(3) and hcount(2));

    end if;

    if rising_edge( clk7 ) then
      if hcount(3)='1' then
        viddel <= vid;
      end if;
    end if;
  end process;

  process (at2clk)
  begin
    if rising_edge( at2clk ) then
      if( viddel='0' ) then
        at2 <= at1;
      else
        at2 <= "00111000";
      end if;
    end if;
  end process;

  process (hcount, vcount, at2, da2(7), flash(4))
  begin
    r <= '0';
    g <= '0';
    b <= '0';
    i <= '0';
    vid   <= '1';
    if  (vcount>=248 and vcount<252) or
        (hcount>=344 and hcount<376) then
      sync <= '0';
    else
      sync <= '1';
      if hcount>=416 or hcount<320 then
        if (da2(7) xor (at2(7) and flash(4)))='0' then
          r <= at2(4);
          g <= at2(5);
          b <= at2(3);
        else
          r <= at2(1);
          g <= at2(2);
          b <= at2(0);
        end if;
        i <= at2(6);
        if hcount<256 and vcount<192 then
          vid <= '0';
        end if;
      end if;
    end if;
  end process;

  process (hcount, vcount, ccount, abus, wr_n, mreq_n)
  begin
    if (vid or (hcount(3) xnor (hcount(2) and hcount(1))))='0' then
      wrv <= '0';
      if (hcount(1) and (hcount(2) xor hcount(3)))='1' then
        addrv <= '0' & std_logic_vector(vcount(7 downto 6) & vcount(2 downto 0)
                  & vcount(5 downto 3) & ccount);
      else
        addrv <= "0110" & std_logic_vector(vcount(7 downto 3) & ccount);
      end if;
    else
      wrv <= not (wr_n or mreq_n or abus(15) or not abus(14));
      addrv <= abus(13 downto 0);
    end if;
  end process;

  process (clk7, hcount)
  begin
    at2clk <= not clk7 or hcount(0) or not hcount(1) or hcount(2);
  end process;

  process (rd_n, wr_n, mreq_n, abus)
  begin
    dbus <= (others => 'Z');
    if rd_n='0' then
      if mreq_n='0' then
        if abus(15 downto 14)="00" then
          dbus <= din_rom;
        else
          dbus <= din_ram;
        end if;
      elsif iorq_n='0' and abus(0)='0' then
        if abus(13)='0' then
         dbus <= "11111110";
       else
         dbus <= "11111111";
       end if;
--        dbus <= "101" & kbcol;
      end if;
    end if;
  end process;

  process (cbis1, cbis2, iorq_n, abus)
  begin
    orbis2 <= cbis1 and ((abus(15) or not abus(14)) nand (iorq_n or abus(0))) and cbis2;
  end process;


  process (orbis2, hcount(0))
  begin
    clkcpu <= hcount(0) or orbis2;
  end process;

  process (clkcpu)
  begin
    if rising_edge( clkcpu ) then
      cbis2 <= (iorq_n or abus(0)) and mreq_n;
    end if;
  end process;

end behavioral;