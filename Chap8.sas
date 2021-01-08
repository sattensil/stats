
run;

**libname chap8
'H:\Data\My Documents\SFO Risk\quigleym\TIME\UC Berkley\Logistic Reg & Survival Analysis\For Students\Logistic\Chapter 8';

libname chap8 'C:\UC Berkley\Logistic Reg & Survival Analysis\For Students\Logistic\Chapter 8';



run;

%macro skipit;

run;

data chap8.lowbirth;
    set lowbirth;

  data chap8.placement;
   set placement;

run;

%mend;

 data lowbirth;
   set chap8.lowbirth;

   run;

 data placement;
  set chap8.placement;

  run;

  proc format;
   value place
   0 = 'outpaitent'
   1 = 'Half Way House'
   2 = 'Residential'
   ;

  **Step 1: Table 8.1;

  proc freq data=placement;
   table place3*VIOL / missing;
   format place3 place. ;
    title 'placement results';

        run;

**Step 2: Table 8.2;

**Step 2a: proc logistic on first place3;

proc logistic data = placement;
  model place3(event='1') = viol;
  output out = m2 p = prob xbeta = logit;
  where place3 in (0,1);
run;

**Step 2b: proc logistic on Second place3;

proc logistic data = placement;
  model place3(event='2') = viol;
  output out = m2 p = prob xbeta = logit;
  where place3 in (0,2);
run;


**Step 2c: Match results using the link functin GLOGIT;


proc logistic data = placement;
  class place3 (ref='0') viol (ref='0');
  model place3 /*(event='0')*/  = viol / link=glogit;
  output out = m2 p = prob xbeta = logit;
run;

****Step 2d: Lets to the Proc Genmod as suggested by Allison to clarify ;
** Why are numbers are different from Hosmer and Lemeshow;

 proc catmod data=placement;
  direct viol;
   model place3  = viol / Noiter;
   response joint;

   run;

**Step 2e Wallet data from  Allison;
** As eventually seen if we use the class statement and include a;
** param=ref then we get results similiar to what is shown in Hosmer and Lemeshow;

%macro skipit;
----------------
WALLET Data Set
----------------

 Data described in Chapter 5 of P.D. Allison, "Logistic Regression
 Using the SAS System: Theory and Application."                 */

 %mend skipit;

 run;

data chap8.wallet;
input wallet male business punish explain;
datalines;
2 0 0 2 0
2 0 0 2 1
3 0 0 1 1
3 0 0 2 0
1 1 0 1 1
3 0 0 1 1
3 0 0 1 1
3 1 0 1 1
3 1 0 1 1
3 0 0 2 1
2 0 1 1 1
3 1 1 1 1
3 1 0 1 1
3 1 0 1 1
3 0 0 1 1
3 0 0 1 0
3 0 0 2 1
2 0 0 3 0
1 1 1 3 0
2 0 0 1 1
2 1 0 2 0
3 0 0 1 1
3 1 0 1 1
3 1 1 1 0
3 1 0 1 1
2 0 0 1 0
2 1 0 3 0
1 1 0 2 0
3 1 0 2 0
3 1 0 1 1
3 0 0 1 1
3 1 0 2 1
1 1 0 1 1
3 0 0 2 0
3 1 0 1 0
3 1 1 2 1
3 0 0 2 0
3 0 0 1 1
3 1 0 1 1
3 0 0 1 1
3 0 0 1 1
3 0 0 1 1
3 0 0 2 0
3 1 1 1 1
3 1 0 1 1
3 0 0 1 1
3 0 0 1 1
3 0 0 1 0
3 0 1 3 0
3 1 0 2 0
2 0 0 2 1
3 0 0 1 1
3 1 0 1 1
3 1 0 1 1
3 1 0 1 0
3 1 1 1 0
3 1 0 1 0
2 1 1 3 1
3 0 0 1 1
3 0 0 3 1
3 0 0 1 1
3 0 0 1 0
3 0 0 1 1
1 0 1 1 1
3 0 0 1 0
3 1 0 1 1
1 1 0 1 0
3 1 0 3 1
2 1 0 3 1
1 1 1 2 1
1 1 0 2 1
3 0 0 1 1
3 0 0 3 0
2 1 0 1 1
2 0 0 1 1
2 1 0 1 1
3 0 0 1 0
3 1 1 1 1
3 1 0 1 1
3 0 0 1 1
3 0 1 1 1
3 0 0 1 1
3 0 0 1 1
3 0 0 2 1
2 1 1 1 0
3 1 0 1 1
3 0 0 1 1
2 1 1 1 1
3 0 0 1 1
3 1 1 1 1
3 0 0 1 1
3 0 0 1 1
3 0 0 1 1
3 0 1 1 1
3 0 0 2 1
1 1 1 1 1
1 1 0 2 0
2 1 0 1 1
1 1 1 1 1
2 1 0 1 1
1 1 1 3 0
2 1 1 1 1
1 1 1 3 1
3 0 0 3 1
3 0 0 1 1
2 0 0 1 1
3 0 0 1 1
1 0 1 3 0
3 0 0 1 1
2 0 0 1 0
3 0 0 1 1
3 0 0 1 1
2 1 0 1 1
3 1 0 1 1
3 0 0 1 1
1 1 0 3 0
2 1 0 1 1
2 0 1 1 1
1 0 0 3 0
1 0 1 2 0
3 0 0 1 1
3 0 0 1 1
3 0 0 1 1
3 1 1 1 1
3 0 0 1 0
3 0 0 1 1
3 1 0 1 1
3 1 1 1 1
3 1 0 1 1
2 1 1 1 1
2 0 0 1 0
3 0 0 1 1
2 1 1 2 0
3 1 0 1 0
2 1 0 1 0
3 0 0 2 1
3 1 1 1 1
1 0 0 3 0
3 0 0 1 1
3 1 1 1 1
3 0 0 1 0
3 0 1 1 0
2 0 0 1 1
3 1 0 1 1
2 1 0 1 0
3 0 0 1 0
2 1 0 1 1
3 1 0 1 1
3 1 0 2 0
3 1 1 2 1
3 1 0 1 1
2 1 0 1 0
3 0 0 1 1
3 1 0 1 1
2 1 1 1 0
3 0 0 1 1
3 1 0 1 1
2 1 0 1 0
3 0 1 2 1
2 1 1 2 1
3 0 0 1 1
1 1 0 1 1
3 1 1 3 1
2 1 0 1 1
1 0 0 1 0
2 1 0 3 0
3 0 0 1 1
2 1 1 1 1
3 0 0 1 1
2 0 0 2 0
2 1 0 1 1
1 1 1 2 0
2 1 0 2 0
2 0 0 1 1
1 0 1 3 0
2 1 0 1 1
2 1 0 1 1
3 1 0 1 1
3 0 0 1 1
2 1 0 1 1
1 1 0 2 0
2 0 1 2 1
3 0 0 2 0
2 1 1 1 1
3 0 1 2 1
1 0 0 3 0
2 1 1 1 0
3 0 0 3 1
2 1 0 2 1
3 0 0 1 1
3 1 0 3 1
3 0 0 1 1
3 1 1 1 1
3 1 0 1 1
2 1 0 1 1
;

run;

**Step 2e1: What does logistic look like;

proc format;
 value wallet
 1 = 'Keep Both'
 2 = 'Keep Money'
 3 = 'Return Both'
;
 value male
  0 = 'Female'
  1 = 'Male'
  ;
  value business
  0 ='Not Bus Major'
  1 = 'Bus Major'
  ;
  value punish
  1 = 'Punished Elementary'
  2 = 'Punished Elem & Middle'
  3 = 'Punihsed All School'
  ;
  Value explain
  0 = 'Not Explained'
  1 = 'Explained'
  ;
  run;

run;


proc freq data=chap8.wallet;
 table wallet*(male business punish explain) / missing;
 format wallet wallet. male male. business business. punish punish. explain explain.;

run;

proc logistic data=chap8.wallet;
 class male (ref='0') business (ref='0') punish (ref='1') explain (ref='0')/param=ref;
 **model wallet(event='3') = male business punish explain;
 model wallet(event='3') = punish;
 where wallet in (1,3);  **and punish in (1,2);

 run;

****Step 2f: Lets return to the original problem;
**   Here we will use a class statement and param=ref;
** That will match what we get in Hosmer and Lemeshow;

 proc freq data=placement;
  table viol / missing;
  title 'viol';

  run;

proc logistic data = placement;
  class place3 (ref='0') viol (ref='0')/param=ref;
  model place3 (event='2')  = viol / link=glogit;
  output out = m2 p = prob xbeta = logit;
run;


**** Step 3: Dervie Table 8.5;

proc format;
 value danger
 0 = 'Unlikely'
 1 = 'Possible'
 2 = 'Probable'
 3 = 'Likely'
;

proc freq data=placement;
 table danger / missing;
 format danger danger.;

 run;

proc logistic data = placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0')/param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='2')  = danger / link=glogit ;
  output out = m2 p = prob xbeta = logit;
run;


***Step 4: Derive Table 8.6;

  data new_placement;
    set placement;
         danger_d=0;
          if danger > 0 then danger_d = 1;
          LOS_5 = sqrt(los);
          L_C = los_5*custd;
run;
options mprint symbolgen;

%macro skipit;

*); */; /*�*/ /*�*/; %mend;

%mend skipit;

run;

%macro hood(data=,var=,num=,intercept_only=,dof=);

   proc logistic data = &data outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='2')  = &var / link=glogit ;
  output out = m2 p = prob xbeta = logit;
run;

   %if (&num=1) %then %do;

      data stats;
           set est;
           format var $12.;
           first_term = (-2*_LNLIKE_);
           ratio =  &intercept_only - first_term;
           var="&var";
           p=1-probchi(ratio,&dof);
           dof=&dof;
           **keep var ratio p;

    proc print data=stats;
       var var _lnlike_ first_term ratio p dof;
            title 'here are stats';

  run;

  %end;
  %else %do;

     data temp;
           set est;
           first_term = (-2*_LNLIKE_);
           ratio =  &intercept_only - first_term;
           var="&var";
           p=1-probchi(ratio,&dof);
           dof=&dof;
           keep var ratio p dof;

     data stats;
          set stats temp;
      keep var ratio p dof;

  %end;

%mend hood;

run;

%hood(data=new_placement,var=age,num=1,intercept_only=1048.742,dof=2);
%hood(data=new_placement,var=race,num=2,intercept_only=1048.742,dof=2);

run;

%hood(data=new_placement,var=gender,num=2,intercept_only=1048.742,dof=2);
%hood(data=new_placement,var=neuro,num=2,intercept_only=1048.742,dof=6);
%hood(data=new_placement,var=emot,num=2,intercept_only=1048.742,dof=2);
%hood(data=new_placement,var=danger,num=2,intercept_only=1048.742,dof=6);
%hood(data=new_placement,var=elope,num=2,intercept_only=1048.742,dof=2);
%hood(data=new_placement,var=LOS,num=2,intercept_only=1048.742,dof=2);
%hood(data=new_placement,var=behav,num=2,intercept_only=1048.742,dof=2);
%hood(data=new_placement,var=custd,num=2,intercept_only=1048.742,dof=2);
%hood(data=new_placement,var=viol,num=2,intercept_only=1048.742,dof=2);
%hood(data=new_placement,var=danger_d,num=2,intercept_only=1048.742,dof=2);

run;

proc print data=stats;
var var ratio dof p;
 title 'here is table 8.6';

 run;


 ***Step 5: Derive Table 8.7;
 ** IN all these cases the key is that place3 (ref=0);
 ** This caused the reference, the denominaator of the odds ratio;
 ** to be 0 and you are predicting the numerator which is 1 or 2;

run;
**FIrst we predict without  having a class statement for place3;

   proc logistic data = new_placement outest=est;
  class /*place3 (ref='0')*/ viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='0')  =  AGE RACE GENDER EMOT DANGER_D ELOPE LOS BEHAV CUSTD VIOL
/ link=glogit ;
  output out = m2 p = prob xbeta = logit;
  title 'Notice that Event = does not impact the coefficent values';
  title 'But the class statement with place3 ref=- or ref=2 does';


run;

**Now we introduce the class statement with ref=0;

   proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 /*(event='0')*/  =  AGE RACE GENDER EMOT DANGER_D ELOPE LOS BEHAV CUSTD VIOL
/ link=glogit ;
  output out = m2 p = prob xbeta = logit;
  title 'Notice that Event = does not impact the coefficent values';
  title2 'But the class statement with place3 ref=0 or ref=2 does';
  title3 'Our Odds ratios are for 0 on the bottom and 1 or 2 on top';


run;

**Lets verify the value of Danger_d by looking at it alone;

   proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 /*(event='0')*/  =  DANGER_D
/ link=glogit ;
  output out = m2 p = prob xbeta = logit;
  title 'Notice that Event = does not impact the coefficent values';
  title2 'But the class statement with place3 ref=0 or ref=2 does';
  title3 'Our Odds ratios are for 0 on the bottom and 1 or 2 on top';


run;


**Verify with a tabulate statement;

data tabulate;
 set new_placement;
  one = 1;

  proc format;
   value place
   0 = 'outpaitent'
   1 = 'Half Way House'
   2 = 'Residential'
   ;
  value danger
   0 = 'Not Danger'
   1 = 'Mayber Danger'
   ;

proc tabulate data=tabulate noseps;
 class place3 danger_d;
 var one ;
table (place3='' all='Total' )*(
 one =' '*sum=''*f=comma20.0
),(danger_d='' all='total')
 / rts=25 condense
;
format place3 place. danger_d danger.;
title "Results for place3=&place3";

run;




 ***Step 6: Derive Table 8.8;

proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='2')  =  AGE RACE DANGER_D LOS BEHAV CUSTD
/ link=glogit ;
  output out = m2 p = prob xbeta = logit;

run;

***Step 7: Derive Table 8.9;

proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='2')  =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit ;
  output out = m2 p = prob xbeta = logit;

run;

***Step 8: Derive Table 8.10;

proc freq data=new_placement;
 table place3 / missing;
 title 'place3';

 run;

**Step 8a: First get the full model as in Sep 7;
proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='2')  =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit ;
  output out = m2 p = prob xbeta = logit;

run;

**Step 8b: Seperate Model First Compare Place3=1 to place3=0;
proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='1')  =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit ;
  output out = m2 p = prob xbeta = logit;
  where place3 in (0,1);
  title 'Results for Place in (0,1)';

run;

**Step 8c: Seperate Model First Compare Place3=2 to place3=0;
proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='2')  =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit ;
  output out = m2 p = prob xbeta = logit;
  where place3 in (0,2);
title 'Results for Place in (0,2)';

run;

**Step 9: Get Hosmer Lemeshow but does not work a/c not a binary response;

**Step 9a: try an duse lackfit but does not work;

proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='2')  =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit lackfit;
  output out = m2 p = prob xbeta = logit;
  title 'Trying to get Hosmer Lemeshow Test for Multinominal Logistic Regression';

run;

**Step 9b: Try and find the cuts individually for each place3;

options mpring symbolgen;

%macro hl(data=,group=,place3=);

  data pre_hosmer;
   set &data;
   rank_prob = prob;
   one = 1;
   if place3 in &place3;

   run;
 proc rank data=pre_hosmer out=rank group=&group;
 var rank_prob;

run;

proc tabulate data=rank noseps;
 class rank_prob;
 var one prob;
table (rank_prob='' all='Total' ),(
 one =' '*sum='Tot #'*f=comma20.0
prob =' '*min ='Min Prob'*f=comma20.4
prob =' '*mean='Mn  Prob'*f=comma20.4
prob =' '*max ='Max Prob'*f=comma20.4

)
 / rts=25 condense
;
title "Results for place3=&place3";

run;

%mend hl;

run;

**%hl(data=m2,group=10,place3= (1));
%hl(data=m2,group=10,place3= (0,1,2))

run;

**Step 9c: We need for each person to get their probablity of having Place=0;
**         Then we take 1-Prob(y=0) and use this to get our rank ordering;
** Key is that that the output m2 has 1500 records so you have to take those;
** with level = 0 because they are probablity that the ID = 0;


proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 (event='0')  =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit lackfit;
  output out = m2 p = prob xbeta = logit;
  title 'Predict the event 0 as that is what we need to do for Table 8.11';

  run;

  proc print data=m2;
   title 'here is m2';

   run;


%macro hlq(data=,group=,place3=,level=);

  data pre_hosmer;
   set &data;
   if _level_ = &level;
   rank_prob = prob;
   one = 1;
   if place3 in &place3;
   prob_no_zero = 1-prob;
   rank_no_zero = prob_no_zero;


   run;
 proc rank data=pre_hosmer out=rank group=&group;
 var rank_prob rank_no_zero;

run;

proc tabulate data=rank noseps;
 class rank_prob rank_no_zero;
 var one prob prob_no_zero;
table (rank_no_zero='' all='Total' ),(
 one =' '*sum='Tot #'*f=comma20.0
prob_no_zero =' '*min ='Min Prob'*f=comma20.4
prob_no_zero =' '*mean='Mn  Prob'*f=comma20.4
prob_no_zero =' '*max ='Max Prob'*f=comma20.4

)
 / rts=25 condense
;
title "Results for place3=&place3";

run;

%mend hl;

run;

%hlq(data=m2,group=10,place3= (0,1,2),level=0)

run;

**Step 9d: Okay now we have the distribution we use that;
** to get the results formated by what we got above;
** and constrain ourselves to levels 0,1,2 as that will point;
** to the probablities we need to get our results;
run;
options mprint symbolgen;

%macro hlqq(data=,group=,place3=,level=);

proc format;
 value prob
 low - 0.0465='0.0465'
0.0465-<0.0906='0.0906'
0.0906-<0.1386='0.1386'
0.1386-<0.2027='0.2027'
0.2027-<0.428='0.428'
0.428-<0.7746='0.7746'
0.7746-<0.8606='0.8606'
0.8606-<0.9003='0.9003'
0.9003-<0.9536='0.9536'
0.9536-<1='1'
;
run;

 data prob0;
  set &data;
  if _level_=0;
  prob0 = prob;
  prob1 = 1-prob;
  keep id prob0 prob1;

run;


%if (&level = 0) %then %do;

  data pre_hosmer;
   set &data;
   if _level_ = &level;
   rank_prob = prob;
   one = 1;
   if place3 in &place3;
   prob_no_zero = 1-prob;
   rank_no_zero = prob_no_zero;
   prob_format = prob;
    place3_0 = 0;
   place3_1 = 0;
   place3_2 = 0;
   if place3=0 then place3_0=1;
   if place3=1 then place3_1=1;
   if place3=2 then place3_2=1;

   run;

 proc rank data=pre_hosmer out=rank group=&group;
 var rank_prob rank_no_zero;

run;

proc tabulate data=rank noseps;
 class rank_prob rank_no_zero prob_format prob_no_zero;
 var one prob place3_0 place3_1 place3_2;
table (prob_no_zero='' all='Total' ),(
 one =' '*sum='Tot #'*f=comma20.0
 place3_0 =' '*sum='# 0'*f=comma20.0
 prob     =' '*sum='Sum Prob'*f=comma20.3
)
 / rts=25 condense
;
format prob_format prob_no_zero prob.;
title "Results for Level=&level";

%end;
%if (&level = 1) %then %do;

data pre_hosmer;
   set &data;
   if _level_ = &level;
   rank_prob = prob;
   one = 1;
   if place3 in &place3;
   prob_no_zero = 1-prob;
   rank_no_zero = prob_no_zero;
   prob_format = prob;
    place3_0 = 0;
   place3_1 = 0;
   place3_2 = 0;
   if place3=0 then place3_0=1;
   if place3=1 then place3_1=1;
   if place3=2 then place3_2=1;

   run;

   proc sql;
    create table pre_hosmer as
         select a.*,
                b.prob0,
                        b.prob1
         from pre_hosmer a,
              prob0      b
     where a.id=b.id
         ;
         quit;


 proc rank data=pre_hosmer out=rank group=&group;
 var rank_prob rank_no_zero;

run;


proc tabulate data=rank noseps;
 class rank_prob rank_no_zero prob_format prob0 prob1;
 var one prob prob_no_zero place3_0 place3_1 place3_2;
table (prob1='' all='Total' ),(
 one =' '*sum='Tot #'*f=comma20.0
 place3_1 =' '*sum='# 1'*f=comma20.0
 prob     =' '*sum='Sum Prob'*f=comma20.2
)
 / rts=25 condense
;
format prob_format prob0 prob1 prob.;
title "Results for Level=&level";

%end;
%if (&level = 2) %then %do;


data pre_hosmer;
   set &data;
   if _level_ = &level;
   rank_prob = prob;
   one = 1;
   if place3 in &place3;
   prob_no_zero = 1-prob;
   rank_no_zero = prob_no_zero;
   prob_format = prob;
    place3_0 = 0;
   place3_1 = 0;
   place3_2 = 0;
   if place3=0 then place3_0=1;
   if place3=1 then place3_1=1;
   if place3=2 then place3_2=1;

   run;

      proc sql;
    create table pre_hosmer as
         select a.*,
                b.prob0,
                        b.prob1
         from pre_hosmer a,
              prob0      b
     where a.id=b.id
         ;
         quit;


 proc rank data=pre_hosmer out=rank group=&group;
 var rank_prob rank_no_zero;

run;

proc tabulate data=rank noseps;
 class rank_prob rank_no_zero prob_format prob0 prob1;
 var one prob prob_no_zero place3_0 place3_1 place3_2;
table (prob1='' all='Total' ),(
 one =' '*sum='Tot #'*f=comma20.0
 place3_2 =' '*sum='# 2'*f=comma20.0
 prob     =' '*sum='Sum Prob'*f=comma20.2
)
 / rts=25 condense
;
format prob_format prob0 prob1 prob.;
title "Results for Level=&level";

run;

%end;


run;

%mend hlqq;

run;

%hlqq(data=m2,group=10,place3= (0,1,2),level=0) ;

run;


%hlqq(data=m2,group=10,place3= (0,1,2),level=1);

run;

%hlqq(data=m2,group=10,place3= (0,1,2),level=2);

run;


**Step 10: Diagnostic Tests Table 8.12;

run;

**Step 10a: Initial data and logistic regression;

data new_placement;
    set placement;
         danger_d=0;
          if danger > 0 then danger_d = 1;
          LOS_5 = sqrt(los);
          L_C = los_5*custd;
run;

proc freq data=new_placement;
 table place3*danger_d / missing;
  title 'How is danger_d working';

  run;


proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 /*(event='0')*/  =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit lackfit;
  output out = m2 p = prob xbeta = logit;
  title 'Predict the event 0 as that is what we need to do for Table 8.11';
  title2 'Note that the class place3 (ref=0) takes priorit over the event=0';


  run;

**Step 10b: try out some diagnostic tools - First try influence and iplots;

ods graphics on;
proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit lackfit influence iplots;
  output out = m2 p = prob xbeta = logit;
  title 'Predict the event 0 as that is what we need to do for Table 8.11';
ods graphics off;

run;

**Step 10C: as seen those do not work because there are more than one reference point;
**          so we try the diagnostic tools on just one logistic at a time;

**PLace3 0 and 1;

ods graphics on;
proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit lackfit;
  output out = m2 p = p xbeta = logit resdev=dr h=pii reschi=pr difchisq=difchi dfbetas=diff_int diff_age diff_race diff_danger_d
                       diff_los_5 diff_behav diff_custd diff_l_c;
  where place3 in (0,1);
  title 'Predict the event 0 as that is what we need to do for Table 8.11';
ods graphics off;

run;

goptions reset = all;
symbol1 pointlabel = ("#id" h=1 )  value=none;
proc gplot data = m2;
  plot difchi*p;
  title 'results for diff chi square';
run;
quit;

symbol1 pointlabel = ("#id" h=1 )  value=none;
proc gplot data = m2;
  plot pii*p;
  title 'results for diff chi square';
run;
quit;


options mprint symbolgen;
%macro graph(var=);

goptions reset = all;
symbol1 pointlabel = ("#id" h=1 )  value=none;
proc gplot data = m2;
  plot &var*p;
 title "Diff Beta Results for var=&var";
run;
quit;

%mend graph;

run;

%graph(var=diff_age);
run;
%graph(var=diff_behav);
%graph(var=diff_custd);
%graph(var=diff_diff_race);
%graph(var=diff_danger_d);
%graph(var=diff_race);
%graph(var=diff_L_C);
run;


**PLace3 0 vs 2;

ods graphics on;
proc logistic data = new_placement outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit lackfit;
  output out = m2 p = p xbeta = logit resdev=dr h=pii reschi=pr difchisq=difchi dfbetas=diff_int diff_age diff_race diff_danger_d
                       diff_los_5 diff_behav diff_custd diff_l_c;
  where place3 in (0,2);
  title 'Predict the event 0 as that is what we need to do for Table 8.11';
ods graphics off;

run;

goptions reset = all;
symbol1 pointlabel = ("#id" h=1 )  value=none;
proc gplot data = m2;
  plot difchi*p;
  title 'results for diff chi square';
run;
quit;

symbol1 pointlabel = ("#id" h=1 )  value=none;
proc gplot data = m2;
  plot pii*p;
  title 'results for diff chi square';
run;
quit;


options mprint symbolgen;
%macro graph(var=);

goptions reset = all;
symbol1 pointlabel = ("#id" h=1 )  value=none;
proc gplot data = m2;
  plot &var*p;
 title "Diff Beta Results for var=&var";
run;
quit;

%mend graph;

run;

%graph(var=diff_age);
run;
%graph(var=diff_behav);
%graph(var=diff_custd);
%graph(var=diff_diff_race);
%graph(var=diff_danger_d);
%graph(var=diff_race);
%graph(var=diff_L_C);
run;

**Step 11 Table 8.13;

proc logistic data = new_placement covout outest=est;
  class place3 (ref='0') viol (ref='0') danger(ref='0') race(ref='0') neuro(ref='0') emot(ref='0') danger_d(ref='0')
        elope(ref='0') custd(ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model place3 =  AGE RACE DANGER_D LOS_5 BEHAV CUSTD L_C
/ link=glogit lackfit;
  output out = m2 p = p xbeta = logit resdev=dr h=pii reschi=pr difchisq=difchi dfbetas=diff_int diff_age diff_race diff_danger_d
                       diff_los_5 diff_behav diff_custd diff_l_c;
  unit age=2 behav=2;
  **where place3 in (0,1);
  title 'Results in Table 8.9';
ods graphics off;

run;

**Step 12: FIgure 8.1;

data _null_;
 set est;

if _name_ in ('Intercept_1') then do;
   call symput('Intercept_1',Intercept_1);
   call symput('Cov_1',LOS_5_1);
 end;
if _name_ in ('Intercept_2') then do;
   call symput('Intercept_2',Intercept_2);
   call symput('Cov_2',LOS_5_2);
 end;


 if _name_ in ('L_C_1') then do;
   call symput('L_C_1',L_C_1);
 end;
if _name_ in ('L_C_2') then do;
   call symput('L_C_2',L_C_2);
 end;
if _name_ in ('LOS_5_1') then do;
   call symput('LOS_5_1',LOS_5_1);
 end;
if _name_ in ('LOS_5_2') then do;
   call symput('LOS_5_2',LOS_5_2);
 end;
run;

 proc print data=est;
  title 'here is est';
  title2 "L_C_1 = &L_C_1 L_C_2=&L_C_2 intercept_1=&intercept_1 cov_1=&cov_1";
  title3 "LOS_5_1 = &LOS_5_1 LOS_5_2=&LOS_5_2 intercept_2=&intercept_2 cov_2=&cov_2";


  run;

  data graph_it;
   set new_placement;
   log_odds1 = 6.068 - 0.639 * LOS_5;
   log_odds2 = 3.086 - 0.254 * LOS_5;
   log_odds1_upper = log_odds1 + 2*sqrt(&intercept_1 + (LOS_5**2)*&los_5_1 +  2*&cov_1);
   log_odds1_lower = log_odds1 - 2*sqrt(&intercept_1 + (LOS_5**2)*&los_5_1 +  2*&cov_1);
   log_odds2_upper = log_odds2 + 2*sqrt(&intercept_2 + (LOS_5**2)*&los_5_2 +  2*&cov_2);
   log_odds2_lower = log_odds2 - 2*sqrt(&intercept_2 + (LOS_5**2)*&los_5_2 +  2*&cov_2);


run;

proc univariate data=graph_it;
 var los log_o;
 where place3 in (0,1);

 run;

proc sort data=graph_it;
 by los;

symbol1 i = join v=circle l=32  c = red;
symbol2 i = join v=none l = 1 c=blue;
symbol3 i = join v=none l = 1 c=blue;
proc gplot data = graph_it;
  plot log_odds1*Los log_odds1_upper*los log_odds1_lower*los / overlay;
  **where place3 in (0,1);
  title "Half Way House  Vs Day Care";

run;
quit;

symbol1 i = join v=circle l=32  c = red;
symbol2 i = join v=none l = 1 c=blue;
symbol3 i = join v=none l = 1 c=blue;
proc gplot data = graph_it;
  plot log_odds2*Los log_odds2_upper*los log_odds2_lower*los / overlay;
  **where place3 in (0,1);
  title " Residential Vs Day Care";

run;
quit;

**Step 13: Table 8.14;

**Step 13a: Start with low birth weight;

proc contents data=lowbirth;
 title 'here is low birth';

 run;

  data new_low_birth;
   set lowbirth;
   bwt_ord = -99999999;
   if bwt > 3500 then bwt_ord = 0;
   if 3000 < BWT <= 3500 then bwt_ord = 1;
   if 2500 < BWT <= 3000 then bwt_ord = 2;
   if BWT <= 2500 then bwt_ord = 3;

   run;

***Step 13b: Table 8.14;

proc freq data=new_low_birth;
 table bwt_ord*smoke / missing;
  title 'BWT_ORD vs Smoke';

  run;

**Step 13c: Verification of Odds provided in top of page 294;

proc logistic data = new_low_birth covout outest=est;
  class bwt_ord(ref='0') smoke (ref='0')  /param=ref;
  **model place3 (event='2')  = viol / link=glogit;
  model bwt_ord = smoke
/ link=glogit lackfit;
  output out = m2 p = p xbeta = logit resdev=dr h=pii reschi=pr difchisq=difchi dfbetas=diff_int diff_smoke;
  title 'Results in Table 8.15';
ods graphics off;

run;

**Step 14: Table 8.15 Adjant Catagory Model;
**     This does not provide the results in table 8.15;
** But it does provide the initial coefficent vales AND;
** The different intercept terms;

proc catmod data = new_low_birth;
  population smoke;
  response alogits;
  model bwt_ord = (0 1 0 0,
                0 0 1 0,
                0 0 0 1,
                1 1 0 0,
                1 0 1 0,
                1 0 0 1) ;
run;
quit;


**Step 15: Table 8.16 Continuation Ratio Model;

**Step 15a: We start with the first logistic which is just 0,1;

proc logistic data = new_low_birth;
   where bwt_ord = 0 | bwt_ord = 1;
   model bwt_ord (event="1") = smoke;
title 'First Row of Table 8.16';
run;

**Step 15b: We start with the first logistic which is just 0 & 1 vs 2;

data new_low_birth2;
  set new_low_birth;
  if (bwt_ord = 0 | bwt_ord = 1) then bcat2 = 0;
  else if bwt_ord = 2 then bcat2 = 1;
  if bwt_ord = 3 then bcat3=1;
  else bcat3=0;
   if bwt > 3500 then bwt_ord2 = 3;
   if 3000 < BWT <= 3500 then bwt_ord2 = 2;
   if 2500 < BWT <= 3000 then bwt_ord2 = 1;
   if BWT <= 2500 then bwt_ord2 = 0;

run;

proc logistic data = new_low_birth2;
   model bcat2 (event="1") = smoke;
title 'Second Row of Table 8.16';
run;

**Step 15b: We start with the first logistic which is just 0 & 1 vs 2;

proc logistic data = new_low_birth2;
   model bcat3 (event="1") = smoke;
title 'third Row of Table 8.16';
run;

**Step 16: Table 8.17 Continuation Ratio Model;
** Results taken from chapter 6 of Allisons SAS book See page 153;

data first;
  set new_low_birth2;
  stage1 = 0;
  stage2 = 0;
  stage3 = 1;
  adv = bwt_ord < 3;
run;

proc freq data=first;
 table bwt_ord*adv / missing;
 title 'first data';

 run;

data second;
  set new_low_birth2;
  stage1 = 0;
  stage2 = 1;
  stage3 = 0;
  if bwt_ord = 3 then delete;
  adv = bwt_ord < 2;
run;


data third;
  set new_low_birth2;
  stage1 = 1;
  stage2 = 0;
  stage3 = 0;
  if bwt_ord >=2 then delete;
  adv = bwt_ord < 1;
run;

data concat;
  set first second third;
run;

proc freq data=concat;
 table adv*(stage1 stage2 stage3) / missing;
  title 'here is concat';

  run;

proc logistic data = concat  ;
 model adv = stage1-stage3 smoke /noint ;
run;


**Step 17: Table 8.18 Proportional Odds Model;

**Step 17a: Results with no change in variable;
**          Results different from book;
**          where the coefficent values is opposite sign;
**          and intercepts are the same;
** NOTE: using decending we are predicting 1 over zero etc;


proc logistic data = new_low_birth2 descending;
  model bwt_ord = lwt ;
  **where bwt_ord in (0,1);


  run;

  **Step 17b: Results with change in variable;
  ** now as we go from low to high birth weight gets higher;

proc logistic data = new_low_birth2 descending;
  model bwt_ord2 = lwt ;

  run;

  **Step 17c: We must take out the descending;
  **          So that we predict prob of being less than K;
  **         over the probablity of being greater than or equal to k in the denominator;


proc logistic data = new_low_birth2; **descending;
  model bwt_ord = lwt ;
  output out=pred p=pred xbeta=logit;
  **where bwt_ord in (0,1);

  proc contents data=pred;
   title 'here is pred';


  run;
 options ps=500;

  proc print data=pred(obs=100);
  var id bwt_ord _level_ lwt pred logit;
  title 'take a look at output';

  run;


  **Step 18: Table 8.19 Smoking Proportional Odds Model;

proc logistic data = new_low_birth2; **descending;
  model bwt_ord = smoke ;
  output out=pred p=pred xbeta=logit;
  **where bwt_ord in (0,1);

  proc contents data=pred;
   title 'here is pred';

  run;
 options ps=500;

  proc print data=pred(obs=100);
  var id bwt_ord _level_ lwt smoke pred logit;
  title 'take a look at output Smoke Example';

  run;
