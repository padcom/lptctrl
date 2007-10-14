<?php
  class StatusTable
  {
    // ------------------------------------------------------------------------
    // Private declarations
    // ------------------------------------------------------------------------

    private function tableHeader()
    {
      $result = "";
      $result = "<form>";
      $result .= "<table width=100% cellspacing=0 style='border: 1px solid black;'>";
      $result .= "<tr style='background: gray; font-size: 25pt'>";
      $result .= "<td width=* align=center style='border-bottom: 2px solid black; border-right: 1px solid black'><strong>Wyjscie</strong></td>";
      $result .= "<td width=200 align=center style='border-bottom: 2px solid black; border-right: 1px solid black'><strong>Stan</strong></td>";
      $result .= "<td width=200 align=center style='border-bottom: 2px solid black; border-right: 1px solid black'><strong>Akcja</strong></td>";
      $result .= "<td width=200 align=center style='border-bottom: 2px solid black'><strong>Aktualizuj</strong></td>";
      $result .= "</tr>";

      return $result;
    }

    private function tableFooter()
    {
      $result = "</table>";
      $result = "</form>";

      return $result;
    }

    private function tableContent()
    {
      $result = "";
      $names = array("(nieuzyte)", "(nieuzyte)", "(nieuzyte)", "Ogrodek przed domem", "Staw i ogrod", "Taras", "Fontanna", "Gniazdka pod tarasem");

/*
      mysql_connect(localhost, "root", "");
      mysql_select_db("lptctrl") or die( "Unable to select database");
      $bits_table = mysql_query("select id,name from BITs order by id");
      while ($row = mysql_fetch_array($bits_table, MYSQL_ASSOC)) 
      {
        $i = $row{'id'};
        $name = $row{'name'};

        $result .= "<tr>";
        $result .= "<td style='border-right: 1px solid black' align=left>$name</td>";
        $result .= "<td style='border-right: 1px solid black' align=center><span id='BIT$i'>undefined</span></td>";
        $result .= "<td style='border-right: 1px solid black' align=center><input type='button' value='Toggle' onclick='ToggleStatusBit($i)'></td>";
        $result .= "<td align=center><input type='button' value='Update' onclick='UpdateStatusBit($i)'></td>";
        $result .= "<td align=center><input type='button' value='Rename' onclick='rename();'></td>";
        $result .= "</tr>";
      }
      mysql_close();
*/
      for ($i = 0; $i <= 7; $i++) 
      {
        $result .= "<tr>";
        $result .= "<td style='font-weight: bold; border-right: 1px solid black' align=left>".$names[$i]."</td>";
        $result .= "<td style='border-right: 1px solid black' align=center><span id='BIT$i'>undefined</span></td>";
        $result .= "<td style='border-right: 1px solid black' align=center><input id='BtnBIT$i' type='button' value='Toggle' onclick='ToggleStatusBit($i)'></td>";
        $result .= "<td align=center><input type='button' value='Aktualizuj' onclick='UpdateStatusBit($i)'></td>";
        $result .= "</tr>";
      }
      
      return $result;
    }

    // ------------------------------------------------------------------------
    // Public declarations
    // ------------------------------------------------------------------------

    public function draw()
    {
      echo $this->tableHeader();
      echo $this->tableContent();
      echo $this->tableFooter();
    }
  }

?>
