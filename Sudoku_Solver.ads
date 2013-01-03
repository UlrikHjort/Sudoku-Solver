-------------------------------------------------------------------------------
--                                                                           --
--                             Sudoku Solver                                 --
--                                                                           --
--                           Sudoku_Solver.ads                               --
--                                                                           --
--                                 SPEC                                      --
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
package Sudoku_Solver is
   type Sudoku_T is array (1..9, 1..9) of Natural;

   ----------------------------------------------------------
   --
   -- Read the sudoku from the file Filename into Sudoku
   --
   ----------------------------------------------------------
   Procedure Read_Sudoku(Filename : in String; Sudoku : in out Sudoku_T);

   ----------------------------------------------------------
   --
   -- Print the Sudoku
   --
   ----------------------------------------------------------
   procedure Print_Sudoku(Sudoku : in Sudoku_T);

   ----------------------------------------------------------
   --
   -- Solve the Sudoku
   --
   ----------------------------------------------------------
   procedure Solve(Sudoku : in out Sudoku_T);
end Sudoku_Solver;
