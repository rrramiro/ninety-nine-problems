/*
% Zebra Puzzle in Datalog
% Define the basic structure - 5 houses with positions 1-5

% Define possible values for each attribute
color(red). color(green). color(white). color(yellow). color(blue).
nationality(norwegian). nationality(german). nationality(danish). nationality(swedish). nationality(english).
drink(tea). drink(coffee). drink(milk). drink(beer). drink(water).
cigarette(dunhill). cigarette(blend). cigarette(pall_mall). cigarette(prince). cigarette(blue_master).
pet(dog). pet(bird). pet(cat). pet(horse). pet(zebra).

% House positions
position(1). position(2). position(3). position(4). position(5).

% A house has a position and all attributes
house(Pos, Color, Nationality, Drink, Cigarette, Pet) :-
    position(Pos),
    color(Color),
    nationality(Nationality),
    drink(Drink),
    cigarette(Cigarette),
    pet(Pet).

% Solution predicate - all 5 houses with unique attributes
solution(H1, H2, H3, H4, H5) :-
    % Define the 5 houses
    house(1, C1, N1, D1, S1, P1),
    house(2, C2, N2, D2, S2, P2),
    house(3, C3, N3, D3, S3, P3),
    house(4, C4, N4, D4, S4, P4),
    house(5, C5, N5, D5, S5, P5),
    
    % All colors must be different
    all_different([C1, C2, C3, C4, C5]),
    % All nationalities must be different
    all_different([N1, N2, N3, N4, N5]),
    % All drinks must be different
    all_different([D1, D2, D3, D4, D5]),
    % All cigarettes must be different
    all_different([S1, S2, S3, S4, S5]),
    % All pets must be different
    all_different([P1, P2, P3, P4, P5]),
    
    % Apply the puzzle constraints
    constraints([(1,C1,N1,D1,S1,P1), (2,C2,N2,D2,S2,P2), (3,C3,N3,D3,S3,P3), 
                 (4,C4,N4,D4,S4,P4), (5,C5,N5,D5,S5,P5)]),
    
    % Return the solution
    H1 = (1,C1,N1,D1,S1,P1),
    H2 = (2,C2,N2,D2,S2,P2),
    H3 = (3,C3,N3,D3,S3,P3),
    H4 = (4,C4,N4,D4,S4,P4),
    H5 = (5,C5,N5,D5,S5,P5).

% Constraint rules based on typical zebra puzzle clues
constraints(Houses) :-
    % 1. The English person lives in the red house
    member((_, red, english, _, _, _), Houses),
    
    % 2. The Swedish person has a dog
    member((_, _, swedish, _, _, dog), Houses),
    
    % 3. The Danish person drinks tea
    member((_, _, danish, tea, _, _), Houses),
    
    % 4. The green house is immediately to the left of the white house
    next_to((_, green, _, _, _, _), (_, white, _, _, _, _), Houses),
    
    % 5. The green house owner drinks coffee
    member((_, green, _, coffee, _, _), Houses),
    
    % 6. The person who smokes Pall Mall has birds
    member((_, _, _, _, pall_mall, bird), Houses),
    
    % 7. The owner of the yellow house smokes Dunhill
    member((_, yellow, _, _, dunhill, _), Houses),
    
    % 8. The person in the middle house drinks milk
    member((3, _, _, milk, _, _), Houses),
    
    % 9. The Norwegian lives in the first house
    member((1, _, norwegian, _, _, _), Houses),
    
    % 10. The person who smokes Blend lives next to the cat owner
    adjacent((_, _, _, _, blend, _), (_, _, _, _, _, cat), Houses),
    
    % 11. The horse owner lives next to the Dunhill smoker
    adjacent((_, _, _, _, _, horse), (_, _, _, _, dunhill, _), Houses),
    
    % 12. The person who smokes Blue Master drinks beer
    member((_, _, _, beer, blue_master, _), Houses),
    
    % 13. The German smokes Prince
    member((_, _, german, _, prince, _), Houses),
    
    % 14. The Norwegian lives next to the blue house
    adjacent((_, _, norwegian, _, _, _), (_, blue, _, _, _, _), Houses),
    
    % 15. The Blend smoker has a neighbor who drinks water
    adjacent((_, _, _, _, blend, _), (_, _, _, water, _, _), Houses).

% Helper predicates
all_different([]).
all_different([H|T]) :- 
    \+ member(H, T), 
    all_different(T).

% Check if X is a member of list L
member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Check if two houses are adjacent (next to each other)
adjacent(H1, H2, Houses) :-
    next_to(H1, H2, Houses).
adjacent(H1, H2, Houses) :-
    next_to(H2, H1, Houses).

% Check if H1 is immediately to the left of H2
next_to((P1,C1,N1,D1,S1,Pet1), (P2,C2,N2,D2,S2,Pet2), Houses) :-
    member((P1,C1,N1,D1,S1,Pet1), Houses),
    member((P2,C2,N2,D2,S2,Pet2), Houses),
    P2 is P1 + 1.

% Query to find who owns the zebra
zebra_owner(Owner) :-
    solution(H1, H2, H3, H4, H5),
    member((_, _, Owner, _, _, zebra), [H1, H2, H3, H4, H5]).

% Query to find who drinks water
water_drinker(Drinker) :-
    solution(H1, H2, H3, H4, H5),
    member((_, _, Drinker, water, _, _), [H1, H2, H3, H4, H5]).

*/


pub def buildHouse(pos:Int32, color: String): Vector[(Int32, String)] =
    List.toVector(((pos, color)):: Nil)
pub def allDifferent(elements: List[String]): Vector[Bool] =
    List.toVector(((elements |> List.toSet |> Set.size) == (elements |> List.size)) :: Nil)

pub def facts:  #{ Colors(String), Positions(Int32),  Houses(Int32, String) | r } = #{
    Colors("red"). Colors("green"). Colors("ivory"). Colors("yellow"). Colors("blue").
    Positions(1). Positions(2). Positions(3). Positions(4). Positions(5).

    Houses(pos, color) :- Positions(pos), Colors(color).   
}
/*
pub def member(): #{ Member(l, List[l]) } with Order[l] = #{
    Member(l, l :: t ).
    Member(l, x :: t ) :- Member(l, t).
}
*/

def zebra(): Unit \ IO = {


    let constraints = #{
        

        Solution(h1, h2, h3, h4, h5, x1) :- 
            Houses(1, c1),
            Houses(2, c2),
            Houses(3, c3),
            Houses(4, c4),
            Houses(5, c5),
            let x1 = allDifferent(c1 :: c2 :: c3 :: c4 :: c5 :: Nil),
            let h1 = buildHouse(1, c1),
            let h2 = buildHouse(2, c2),
            let h3 = buildHouse(3, c3),
            let h4 = buildHouse(4, c4),
            let h5 = buildHouse(5, c5).
       
        LocalVar("x"; 1).
        
    };


    let allPossibilities = solve facts() <+> constraints;
    let result = query allPossibilities select ((x,y)) from LocalVar(x; y);

    println(result)
}