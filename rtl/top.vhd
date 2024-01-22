LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

ENTITY top IS
PORT(
            key_reset          : in  std_logic ;
            clk                : in  std_logic  ;                             -- clk
            key1port_export    : in  std_logic ;                                -- export
            led8port_export    : out std_logic_vector(7 downto 0);                     -- export                        
            seg_24_port_export : out std_logic_vector(23 downto 0);                    -- export
            sw4port_export     : in  std_logic_vector(3 downto 0)  );  -- export
END ENTITY top;


ARCHITECTURE ART OF top IS

    component system_nios is
        port (
            clk_clk          : in  std_logic                    := 'X';             -- clk
            key1port_export  : in  std_logic                    := 'X';             -- export
            led8port_export  : out std_logic_vector(7 downto 0);                    -- export
            reset_reset_n    : in  std_logic                    := 'X';             -- reset_n
            counter10_export : out std_logic_vector(11 downto 0);                    -- export
            sw4port_export   : in  std_logic_vector(3 downto 0) := (others => 'X')  -- export
        );
    end component system_nios;
    
    component bin_to_7seg is
        port (
            SW : in std_logic_vector (3 downto 0);
            HEX0 : out std_logic_vector (7 downto 0));
        end component bin_to_7seg;

SIGNAL counter10_export :  std_logic_vector(11 downto 0); 
SIGNAL seg_export :  std_logic_vector(23 downto 0);

begin
    
    
    
    u0 : component system_nios
        port map (
            clk_clk          => clk,          --       clk.clk
            key1port_export  => key1port_export,  --  key1port.export
            led8port_export  => led8port_export,  --  led8port.export
            reset_reset_n    => ( key_reset),    --     reset.reset_n
            counter10_export => counter10_export, -- counter10.export
            sw4port_export   => sw4port_export    --   sw4port.export
        );
    
    seg0 : component bin_to_7seg 
        port map (
            SW    => counter10_export(3 downto 0),
            HEX0  => seg_export(7 downto 0)
                  );
      
    seg1 : component bin_to_7seg 
        port map (
            SW    => counter10_export(7 downto 4),
            HEX0  => seg_export(15 downto 8)
                  );

    seg2 : component bin_to_7seg 
        port map (
            SW    => counter10_export(11 downto 8),
            HEX0  => seg_export(23 downto 16)
                  );



 
seg_24_port_export<=seg_export;
    
 END ARCHITECTURE ART;