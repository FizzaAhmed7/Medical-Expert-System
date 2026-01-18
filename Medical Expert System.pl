% ===============================================
%           MEDICAL EXPERT SYSTEM
% ===============================================

% --- Diseases ---
disease(flu).
disease(malaria).
disease(typhoid).
disease(covid).
disease(heart_attack).

% --- Symptoms for Diseases ---
has_symptoms(flu,[fever,cough,sore_throat,runny_nose,body_ache]).
has_symptoms(malaria,[fever,sweating,nausea,headache,body_ache]).
has_symptoms(typhoid,[fever,constipation,nausea,vomit,headache,abdominal_pain]).
has_symptoms(covid,[fever,cough,tiredness,loss_of_smell,headache]).
has_symptoms(heart_attack,[chest_pain,short_breath,left_arm_pain,sweating,dizzy]).

% --- Severity (1 mild - 5 severe) ---
severity(flu,2).
severity(malaria,5).
severity(typhoid,4).
severity(covid,5).
severity(heart_attack,5).

% --- Treatment ---
treatment(flu,'Rest, warm fluids, paracetamol, vitamin C, avoid strenuous activity').
treatment(malaria,'Doctor visit, anti-malaria medicine, hydration, rest').
treatment(typhoid,'Antibiotics, clean water, soft food, electrolyte drinks, avoid raw food').
treatment(covid,'Isolate, rest, fluids, doctor if breathing issue, fever reducers, monitor oxygen').
treatment(heart_attack,'EMERGENCY: Call ambulance, chew aspirin, CPR if needed, hospital care').

% --- Prevention ---
prevent(flu,'Wash hands, keep warm, avoid crowded places, get flu vaccine annually').
prevent(malaria,'Mosquito nets, avoid mosquitoes, insect repellents, drain stagnant water').
prevent(typhoid,'Boiled water, hygiene, avoid street food, vaccine if traveling to risk areas').
prevent(covid,'Mask, sanitise, avoid crowds, vaccination, maintain distance').
prevent(heart_attack,'Exercise, avoid oily food, reduce stress, maintain healthy weight, regular checkups').

% --- Count Matching Symptoms ---
match_count([], _, 0).
match_count([H|T], L, C) :-
    member(H, L), match_count(T, L, C2), C is C2 + 1.
match_count([_|T], L, C) :-
    match_count(T, L, C).

% --- Confidence Formula ---
confidence(UserSymptoms, Disease, Percent) :-
    has_symptoms(Disease, DiseaseList),
    match_count(UserSymptoms, DiseaseList, M),
    length(DiseaseList, T),
    Percent is (M * 100) / T.

% --- Find Best Disease ---
find_best_disease(UserSymptoms, BestDisease, BestConfidence) :-
    confidence(UserSymptoms, flu, C1),
    confidence(UserSymptoms, malaria, C2),
    confidence(UserSymptoms, typhoid, C3),
    confidence(UserSymptoms, covid, C4),
    confidence(UserSymptoms, heart_attack, C5),
    Pairs = [C1-flu, C2-malaria, C3-typhoid, C4-covid, C5-heart_attack],
    max_member(BestConfidence-BestDisease, Pairs),
    BestConfidence > 0.

% --- Collect All Possible Symptoms ---
all_symptoms(AllSymptoms) :-
    findall(S, (has_symptoms(_, L), member(S, L)), L1),
    sort(L1, AllSymptoms).

% --- Ask User Symptoms ---
ask([], []).
ask([S|T], [S|A]) :-
    write('Do you have '), write(S), write('? (yes/no): '),
    read(Response),
    Response == yes, !,
    ask(T, A).
ask([_|T], A) :-
    ask(T, A).

% --- Start the Expert System ---
start :-
    nl, write('=============================================='), nl,
    write('           WELCOME TO EXPERT SYSTEM           '), nl,
    write('=============================================='), nl,
    write('This system diagnoses your illness by symptoms.'), nl,
    write('Please answer yes or no.'), nl,
    write('----------------------------------------------'), nl,

    write('Enter your name: '), read(Name),
    nl, write('Hello '), write(Name), write(', let''s begin!'), nl, nl,

    all_symptoms(AllSymptoms),
    ask(AllSymptoms, UserSymptoms),

    find_best_disease_start(UserSymptoms, Name).

find_best_disease_start(UserSymptoms, Name) :-
    find_best_disease(UserSymptoms, Best, Conf), !,
    nl, write('=========== DIAGNOSIS REPORT ================='), nl,
    write('Name: '), write(Name), nl,
    write('Your Symptoms: '), write(UserSymptoms), nl,
    write('----------------------------------------------'), nl,
    severity(Best, Sev),
    treatment(Best, Treat),
    prevent(Best, Prev),
    write('Possible Disease: '), write(Best), nl,
    write('Confidence: '), write(Conf), write('%'), nl,
    write('Severity Level: '), write(Sev), nl,
    write('Treatment: '), write(Treat), nl,
    write('Prevention: '), write(Prev), nl,
    nl, write('----------------------------------------------'), nl,
    write('Thank you for using the Expert System!'), nl,
    write('Stay healthy!'), nl,
    write('=============================================='), nl.

find_best_disease_start(_, _) :-
    nl, write('----------------------------------------------'), nl,
    write('No matching disease. Consult a doctor.'), nl,
    write('----------------------------------------------'), nl.
