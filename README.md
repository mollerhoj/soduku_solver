Solving a sudoku with constraint programming
============================================
by Jens Dahl Mollerhoj

A small ruby script that uses the forward checking algorithm to solve a sudoku.

This project was designed for an AI class at the IT-university:
"Intelligent Systems Programming 2013"

At this time of writing, the exercise can be found at:

http://www.decisionoptimizationlab.dk/images/stories/ISP/2014/10/project3.pdf

The following is a 'Project report'. (I have to make one for my course, if you
want to keep your sanity, I would stop reading now.)

Project report
==============

### Design goals

Instead of implementing implementation specific optimisation from the beginning
(which is usually a bad idea), I have had my focus on a clean and readable
implementation. Since I have been working alone and on a schedule, I have
preferred a quick (and a little bit hackish) development style.

I have used variable names that are similar or the same as in the assignment notes. I've also included some comments to help out understanding my code.

### A description of the files:

#### sodoku.rb
  A little script that solves the soduku given in the end of the file. Run the script with
  ```
  ruby sodoku.rb
  ```
  
#### affected.rb
  Exposes the
  ```
  affected(x)
  ```
  method. Described below

### A description of the methods:
  
#### affected(x) 
  This method takes an index, and returns a list of all the
  indexes that are connected by constraints. The constraints are imposed on
  all indexes in the same row, column and box as the index.

  As an example, consider calling affected(49). Looking at the matrix below,
  we see that the affected indexes are: 04, 13, 22, 30, 31, 32, 39, 40, 41, 45, 46, 47, 48, 49, 50, 51, 52, 53, 58, 67 and 76
  
     ```
     00 01 02  03*04*05  06 07 08
     09 10 11  12*13*14  15 16 17
     18 19 20  21*22*23  24 25 26

     27 28 29 *30*31*32* 33 34 35
     36 37 38 *39*40*41* 42 43 44
    *45*46*47**48*XX*50**51*52*53*
     
     54 55 56  57*58*59  60 61 62
     63 64 65  66*67*68  69 70 71
     72 73 74  75*76*77  78 79 80
     ```

#### clear(h)
  Clear h lines of the screen (in a xterm terminal) by moving the cursor h lines up.

#### render(asc)
  Draw the sudoku (as it is currently filled out) on the screen.

#### deep_clone(asc)
  Clone an array and its subarrays

#### arc_con(x,v,d,asc)
  Set the variable x in asc to v. Then remove v from the domain of all affected variables.
  * x the variable to set.
  * v the value that x is set to
  * d the array of domains that must be updated (inplace)
  * asc the current assignment

  This method ensures arc consistency by removing variables in from the domain. It uses the 'affected(x)' method described above to determine what domains should be updated.

#### arc_con_all(asc,d)
  Called initially to ensure that the initial assignment by the sodoku is taken into account. It scans the sodoku to find variables that are set (not 0), and uses arc_con to remove those variables by the affected domains.

#### fc(asc,d)
  Is the forward checking algorithm described in the notes. Since the variable names are the same, it should be pretty easy to follow.

  * 1. if all variables has been assigned, we are done. Else:
  * 2. Look at the first empty variable and set it to the first possible value from it's domain.
  * 3. Impose arc consistancy after setting the variable.
  * 4. Render the new soduko
  * 5. Recur
  * 6. If the recuring failed, then restore the domains to the initial domain, and se the variable to 0 (backtrack)
  * 7. If the recuring succeded, we are done.

#### first_zero(asc)
  Return the index of the first free variable.

#### no_zeros?(asc)
  Are there any free variables?

### License

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE: www.wtfpl.net
