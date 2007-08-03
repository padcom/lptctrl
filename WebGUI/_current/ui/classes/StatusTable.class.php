<?php
  class StatusTable
  {
    // ------------------------------------------------------------------------
    // Private declarations
    // ------------------------------------------------------------------------

    private function tableHeader()
    {
      $result = "";
      $result .= "<table width=100% cellspacing=0 style='border: 1px solid black;'>";
      $result .= "<tr style='background: gray'>";
      $result .= "<td width=* align=center style='border-bottom: 2px solid black; border-right: 1px solid black'>Output</td>";
      $result .= "<td width=100 align=center style='border-bottom: 2px solid black; border-right: 1px solid black'>Status</td>";
      $result .= "<td width=100 align=center style='border-bottom: 2px solid black; border-right: 1px solid black'>Actions</td>";
      $result .= "<td width=100 align=center style='border-bottom: 2px solid black'>Update</td>";
      $result .= "</tr>";

      return $result;
    }

    private function tableFooter()
    {
      $result = "</table>";

      return $result;
    }

    private function tableContent()
    {
      $result = "";
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
        $result .= "</tr>";
      }
      mysql_close();
*/

      for ($i = 0; $i <= 7; $i++) 
      {
        $result .= "<tr>";
        $result .= "<td style='border-right: 1px solid black' align=left>BIT$i</td>";
        $result .= "<td style='border-right: 1px solid black' align=center><span id='BIT$i'>undefined</span></td>";
        $result .= "<td style='border-right: 1px solid black' align=center><input type='button' value='Toggle' onclick='ToggleStatusBit($i)'></td>";
        $result .= "<td align=center><input type='button' value='Update' onclick='UpdateStatusBit($i)'></td>";
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
