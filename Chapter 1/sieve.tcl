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

proc checkSieve {result} {
  return [expr {$result == {2 3 5 7 11 13 17 19 23 29 31 37 41 43 47}}]
}

proc sieve {n} {

  # Create list {0 0 2 .. n}
  set A {0 0}
  for {set i 2} {$i <= $n} {incr i} {
    lappend A $i
  }

  # Eliminate numbers
  for {set i 2} {$i <= sqrt($n)} {incr i} {

    # Eliminate multiplies of $i
    if {[lindex $A $i] != 0} {

      # Start with i * i
      # All multiples of i smaller
      # than i were eliminated earlier
      set j [expr {$i**2}]

      # Add i until limit is reached
      while {$j <= $n} {

        # Eliminate current number
        lset A $j 0

        # Add i to get its next multiple
        incr j $i

      }

    }

  }

  # Collect all non-zero values
  for {set i 2} {$i <= $n} {incr i} {
    set num [lindex $A $i]
    if {0 != $num} {
      lappend L $num
    }
  }

  return $L

}


# Constants
set nums {1892324 918232}
set divisor 532
set sieveLimit 50

# Collect results
lappend results\
  [gcdR {*}$nums]\
  [gcdI {*}$nums]\
  [gcdC {*}$nums]

# Test functions
puts [expr {[checkSieve [sieve $sieveLimit]] &&\
            [checkResults $divisor $results]}]
