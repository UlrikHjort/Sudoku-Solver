-------------------------------------------------------------------------------
--                                                                           --
--                             Sudoku Solver                                 --
--                                                                           --
--                               Sudoku.adb                                  --
--                                                                           --
--                                 Main                                      --
--                                                                           --
--                   Copyright (C) 2004 Ulrik Hørlyk Hjort                   --
--                                                                           --
--  Sudoku_Solver is free software;  you can  redistribute it                --
--  and/or modify it under terms of the  GNU General Public License          --
--  as published  by the Free Software  Foundation;  either version 2,       --
--  or (at your option) any later version.                                   --
--  Sudoku_Solver is distributed in the hope that it will be                 --
--  useful, but WITHOUT ANY WARRANTY;  without even the  implied warranty    --
--  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                  --
--  See the GNU General Public License for  more details.                    --
--  You should have  received  a copy of the GNU General                     --
--  Public License  distributed with Yolk.  If not, write  to  the  Free     --
--  Software Foundation,  51  Franklin  Street,  Fifth  Floor, Boston,       --
--  MA 02110 - 1301, USA.                                                    --
--                                                                           --
-------------------------------------------------------------------------------
with Sudoku_Solver; use Sudoku_Solver;

procedure Sudoku is

  Sudoku_File : Sudoku_T;

begin
   Read_Sudoku("./data/Sudoku1.dat", Sudoku_File);
   Solve(Sudoku_File);
   Print_Sudoku(Sudoku_File);

   Read_Sudoku("./data/Sudoku2.dat", Sudoku_File);
   Solve(Sudoku_File);
   Print_Sudoku(Sudoku_File);
end Sudoku;
