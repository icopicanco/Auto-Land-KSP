sas off.
rcs off.
set e to 0.
set rm to 1.
stage.
set pid to 0.
set p to 0.
set i to 0.
set stp to -300.
set x to 1.
set pet to 0.
set dt to 0.
set t0 to 0.
set tat to 0.

SET t0 TO TIME:SECONDS.
until rm = 0 {
    CLEARSCREEN.
    SET tat TO TIME:SECONDS.
    set dt to tat-t0.
    if rm = 1{
        
        lock throttle to 1.
        lock steering to up.
        gear off.
        
        if alt:radar>10000{
            set rm to 2.
        }
    }
    if rm = 2 {
        print "runmode 2".
        set steering to heading(90,90*(1-alt:radar/50000)).
        
        if SHIP:APOAPSIS>89800{
            set rm to 3.
        }
    }
    if rm = 3{

        lock throttle to 0.
        if eta:apoapsis<10{
            set rm to 4.
            stage.
        }
    }

    if rm = 4 {
        LOCK Throttle TO 0.
        gear on.
        brakes on.
        lock throttle to 0.
        LOCK steering to up.
        if alt:radar<9000{
            set pid to 1.
            set rm to 5.
        }
       
    }else{
    
    }
    IF ship:verticalspeed = 0 {



            if e=2{
            lock throttle to 0.
            set pid to 0.
            set rm to 0.
            }
            wait 10.
             set e to 2.
        
    }
    if pid = 1{
        
        set kp to 0.1.
        set ki to 0.01.

        lock steering to up.

        set err to stp-ship:verticalspeed.
        set i to dt*err+i.
        set p to err.

        lock throttle to kp*p + ki*i.
        print"--------------------------------".
        print"KOS automated landing booster".
        print"".
        print "SetPoint = " + stp.
        print "vertticalSpeed = "+ ship:verticalspeed.     
        print "error = "+err.
        print "P = " + kp*p.
        print "I = " + ki*i.
        print "dt = " + dt.
        print "throttle =" + throttle.
        print "mode = "+x.
        print"--------------------------------".
        if ship:verticalspeed<0{
            if pet = 0{
                set i to 0.
                set pet to 1.    
            }
        }
        if alt:radar<1200{
            if x = 1{
            set stp to -19.
            set i to 0.
            set x to 0.
            }
        }
                if alt:radar<60{
            if x = 0{
            set stp to -3.
            set i to 0.
            set x to 1.
            }
        }
        
    }
set t0 to tat.
}
