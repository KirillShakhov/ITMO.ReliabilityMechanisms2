bool p = false;
proctype allowed_cases()
{
    if
    :: (true) -> p = true;
    :: (true) -> p = false; p = true;
    :: (true) -> p = true; p = true; p = false;
    :: (true) -> p = true; p = false; p = true; p = false;
    :: (true) -> p = false; p = true; p = true; p = false;
    :: (true) -> p = false; p = true; p = false; p = true; p = false;
    :: (true) -> p = false; p = true; p = false; p = true; p = false; p = true;
    :: (true) -> p = false; p = true; p = false; p = true; p = false; p = true; p = false;
    fi;
}
proctype forbidden_cases()
{
    if
    :: (true) -> p = false;
    :: (true) -> p = true; p = false;
    :: (true) -> p = false; p = true; p = false;
    fi;
}
init
{
    run allowed_cases();
    // Uncomment this line to test forbidden cases
    run forbidden_cases();
}

#define SOLUTION1 (<> (p && X(<>(p))))
ltl p1 { (SOLUTION1) }
ltl np1 { !(SOLUTION1) }