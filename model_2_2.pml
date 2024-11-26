// 2.2. a обязательно случится, но только во время b

bool a = false;
bool b = false;

proctype allowed_cases()
{
	if
		::( true ) ->
			b = true;
			a = true;
		::( true ) ->
			b = true;
			a = true;
			a = false;
			b = false;
		::( true ) ->
			b = true;
			b = false;
			b = true;
			a = true;
			a = false;
			b = false;
		::( true ) ->
			atomic { a = true; b = true; }
		::( true ) ->
			atomic { a = true;  b = true; }
			atomic { a = false; b = false; }
	fi
}

proctype forbidden_cases()
{
	if
		::( true ) ->
			skip;
		::( true ) ->
			a = true;
		::( true ) ->
			b = true;
		::( true ) ->
			a = true;
			a = false;
		::( true ) ->
			b = true;
			b = false;
		::( true ) ->
			a = true;
			b = true;
			b = false;
			a = false;
		::( true ) ->
			b = true;
			a = true;
			b = false;
			a = false;
	fi
}

init
{
	run allowed_cases();
	//run forbidden_cases();
}

#define SOLUTION1 (<>a && ([](a->b)))

ltl  p1 {  ( SOLUTION1 ) }
ltl np1 { !( SOLUTION1 ) }
