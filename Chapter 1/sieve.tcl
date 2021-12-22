#!/usr/bin/tclsh

# Greatest Common Divisor

# Recursive
proc gcdR {m n} {
  return [expr {0 == $n ?\
    $m :\
    [gcdR $n [expr {$m%$n}]]}]
}

# Iterative
proc gcdI {m n} {
  while {0 != $n} {
    set r [expr {$m%$n}]
    set m $n ; set n $r
  }
  return $m
}

# Consecutive integers
proc gcdC {m n} {
  set t [expr {min($m,$n)}]
  while {0 != $m%$t||\
         0 != $n%$t} {
    incr t -1
  }
  return $t
}

proc checkResults {d results} {
  foreach r $results {
    if {$d != $r} {
      return 0
    }
  }
  return 1
}

# Constants
set nums {1892324 918232}
set divisor 532

# Collect results
lappend results\
  [gcdR {*}$nums]\
  [gcdI {*}$nums]\
  [gcdC {*}$nums]

# Check results
puts [checkResults $divisor $results]
