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

# Find all common elements in two sorted lists
proc commonElements {list1 list2} {

  set index1 0 ; set index2 0
  set len1 [llength $list1] ; set len2 [llength $list2]
  set result {}

  while {$index1 < $len1 && $index2 < $len2} {

    set el1 [lindex $list1 $index1] ; set el2 [lindex $list2 $index2]

    # Increment both indices
    if {$el1 == $el2} {
      lappend result $el1
      incr index1 ; incr index2

    # Increment index with smaller value
    } else {
      incr index[expr {$el1 < $el2 ? 1 : 2}]
    }

  }

  return $result

}


proc lockerDoors {n} {

  set lockers {}

  # Create n lockers
  for {set i 0} {$i < $n} {incr i} {

    # All lockers are initially closed
    lappend lockers 0

  }

  # Make n passes by the lockers
  for {set i 0} {$i < $n} {incr i} {

    # Toggle door every 'step' lockers
    set step [expr {$i+1}]

    # Always start with first locker
    set index 0

    # Index must be smaller than list size
    while {$index < $n} {

      # Toggle locker
      lset lockers $index [expr {[lindex $lockers $index] == 0 ? 1 : 0}]

      # Go to next locker
      incr index $step

    }

  }

  return $lockers

}

# Constants
set nums {1892324 918232}
set divisor 532
set sieveLimit 50
set elements1 {2 5 5 5}
set elements2 {2 2 3 5 5 7}
set commonElementsResult {2 5 5}

# Collect results
lappend results\
  [gcdR {*}$nums]\
  [gcdI {*}$nums]\
  [gcdC {*}$nums]

# Test functions
puts "Tests: [expr {[checkSieve [sieve $sieveLimit]] &&\
             [checkResults $divisor $results] &&\
             [expr {[commonElements $elements1 $elements2] ==\
                    $commonElementsResult}]}]"

puts "Lockers: [lockerDoors 5]"
