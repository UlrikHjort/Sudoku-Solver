-------------------------------------------------------------------------------
--                                                                           --
--                             Sudoku Solver                                 --
--                                                                           --
--                           Sudoku_Solver.adb                               --
--                                                                           --
--                                 BODY                                      --
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
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;

package body Sudoku_Solver is

   type Index_T is
      record
         Row    : Positive;
         Column : Positive;
      end record;

   Sudoku_Working_Copy : Sudoku_T;

   ----------------------------------------------------------
   --
   -- Read the sudoku from the file Filename into Sudoku
   --
   ----------------------------------------------------------
   Procedure Read_Sudoku(Filename : in String; Sudoku : in out Sudoku_T) is

      Data_File : FILE_TYPE;
      Row       : Positive := 1;

   begin
      Open(Data_File, In_File, Filename);

      while not End_Of_File(Data_File) loop
         if End_Of_Line(Data_File) then
            Skip_Line(Data_File);
         else
            for I in 1 .. 9 loop
               Get(Data_File,Sudoku(Row,I));
            end loop;
            Row := Row + 1;
         end if;
         exit when Row > 9;
      end loop;
      Close(Data_File);
   exception
      when Constraint_Error =>
      Close(Data_File);
   end Read_Sudoku;



   ----------------------------------------------------------
   --
   -- Return next index in Sudoku matrix
   --
   ----------------------------------------------------------
   function Next_Index(Index : Index_T) return Index_T is
      N_Index : Index_T := Index;

   begin
      if N_Index.Row < 9 then
         N_Index.Row := N_Index.Row + 1;
      else
         N_Index.Row := 1;
         N_Index.Column := N_Index.Column + 1;
      end if;
      return N_Index;
   end Next_Index;


   ----------------------------------------------------------
   --
   -- Try to insert Number at Index in Sudoku
   --
   ----------------------------------------------------------
   function Insert_Number(Index : Index_T; Number : Positive) return Boolean is
      Row    : constant Positive := Positive((((Index.Row-1)/3)*3) +1);
      Column : constant Positive := Positive((((Index.Column-1)/3)*3) +1);

   begin
      -- Check row and column for existing number
      for I in 1 .. 9 loop

         if Sudoku_Working_Copy(I,Index.Column) = Number then
            return False;
         end if;

         if Sudoku_Working_Copy(Index.Row,I) = Number then
            return False;
         end if;
      end loop;

      -- Check 3x3 sub block  for existing number
      for I in 0 .. 2 loop
         if Sudoku_Working_Copy(Row,Column + I ) = Number then
            return False;
         end if;

         if Sudoku_Working_Copy(Row+1,Column + I ) = Number then
            return False;
         end if;

         if Sudoku_Working_Copy(Row+2,Column + I ) = Number then
            return False;
         end if;
      end loop;

      return True;
   end Insert_Number;


   ----------------------------------------------------------
   --
   -- Solve current index
   --
   ----------------------------------------------------------
   function Solve_Index(Index : Index_T) return Boolean is

   begin
      if ((Index.Row > 9) or (Index.Column >9)) then
         return True;
      end if;

      if Sudoku_Working_Copy(Index.Row,Index.Column) /= 0 then
         return Solve_Index(Next_Index(Index));
      end if;

      for Number in 1 .. 9 loop
         if(Insert_Number(Index,Number)) then
            Sudoku_Working_Copy(Index.Row,Index.Column) := Number;
            if (Solve_Index(Next_Index(Index))) then
               return True;
            end if;
         end if;
      end loop;
      Sudoku_Working_Copy(Index.Row,Index.Column) := 0;
     return False;
   end Solve_Index;


   ----------------------------------------------------------
   --
   -- Print the Sudoku
   --
   ----------------------------------------------------------
   procedure Print_Sudoku(Sudoku : in Sudoku_T) is

   begin
      for R in 1 .. 9 loop
         for C in 1 .. 9 loop
            Put(Integer'Image(Sudoku(R,C)) & " ");
         end loop;
         New_Line;
      end loop;
      New_Line;
      New_Line;
   end Print_Sudoku;

   ----------------------------------------------------------
   --
   -- Solve the Sudoku
   --
   ----------------------------------------------------------
   procedure Solve(Sudoku : in out Sudoku_T) is
      Index : constant Index_T := (Row => 1, Column =>1);
      B     : Boolean;

   begin
      Sudoku_Working_Copy := Sudoku;
      B := Solve_Index(Index);
      Sudoku := Sudoku_Working_Copy;
   end Solve;
end Sudoku_Solver;
