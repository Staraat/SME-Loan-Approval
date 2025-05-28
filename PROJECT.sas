/**********************************************************************************************
* Developer name:      Mr. CHEAH JUN HONG
* Job position:        Data Scientist, Lasiandra Finance Inc. (LFI), New York, USA 
* Program name:        MYDAP_PROJECT_TP081634_OCT_2024.sas
* Description:         Loan application status prediction - 1 - 2 lines
* Date first written:  Monday, December 02 2024
* Date last updated:   Monday, February 08 2025
* Folder name:         DAP_FT_OCT_2024_TP081634
* Library name:        (SAS permanent library or user-defined library)
**********************************************************************************************/
/* 6.3 Extract the TRAINING _DS’s metadata/Data Dictionary*/

PROC CONTENTS DATA = LIBOCT34.TRAINING_DS;

RUN;

/* 6.3 Extract the TRAINING _DS’s metadata/Data Dictionary*/

PROC SQL;

DESCRIBE TABLE LIBOCT34.TRAINING_DS;

RUN;

TITLE 'Univariate Analysis of the Categorical Variable : FAMILY_MEMBERS';

PROC FREQ DATA = LIBOCT34.TRAINING_DS;

TABLE FAMILY_MEMBERS;

RUN;

ODS GRAPHICS / RESET WIDTH = 3.0 IN HEIGHT = 4.0 IN IMAGEMAP;

PROC SGPLOT DATA = LIBOCT34.TRAINING_DS;

VBAR FAMILY_MEMBERS;

RUN;

TITLE 'Univariate Analysis of the Categorical Variable : MARITAL_STATUS';

PROC FREQ DATA = LIBOCT34.TRAINING_DS;

TABLE MARITAL_STATUS;

RUN;

ODS GRAPHICS / RESET WIDTH = 3.0 IN HEIGHT = 4.0 IN IMAGEMAP;

PROC SGPLOT DATA = LIBOCT34.TRAINING_DS;

VBAR MARITAL_STATUS;

RUN;

TITLE 'Univariate Analysis of the Categorical Variable : EMPLOYMENT';

PROC FREQ DATA = LIBOCT34.TRAINING_DS;

TABLE EMPLOYMENT;

RUN;

ODS GRAPHICS / RESET WIDTH = 3.0 IN HEIGHT = 4.0 IN IMAGEMAP;

PROC SGPLOT DATA = LIBOCT34.TRAINING_DS;

VBAR EMPLOYMENT;

RUN;

/***Univariate Analysis of the continuous variable : CANDIDATE_INCOME***/
TITLE 'Univariate Analysis of the continuous variable : CANDIDATE_INCOME';

PROC MEANS DATA = LIBOCT34.TRAINING_DS N NMISS MIN MAX MEAN MEDIAN STD;

VAR CANDIDATE_INCOME;

RUN;

ODS GRAPHICS / RESET WIDTH = 3.0 IN HEIGHT = 4.0 IN IMAGEMAP;

PROC SGPLOT DATA = LIBOCT34.TRAINING_DS;

HISTOGRAM CANDIDATE_INCOME;

TITLE 'Univariate Analysis of the continuous variable : CANDIDATE_INCOME';

RUN;


/***Univariate Analysis of the continuous variable : LOAN_AMOUNT***/
TITLE 'Univariate Analysis of the Continuous Variable : LOAN_AMOUNT';

PROC MEANS DATA = LIBOCT34.TRAINING_DS N NMISS MIN MAX MEAN MEDIAN STD;

VAR LOAN_AMOUNT;

RUN;

ODS GRAPHICS / RESET WIDTH = 3.0 IN HEIGHT = 4.0 IN IMAGEMAP;

PROC SGPLOT DATA = LIBOCT34.TRAINING_DS;

HISTOGRAM LOAN_AMOUNT;

TITLE 'Univariate Analysis of the Continuous Variable : LOAN_AMOUNT';

RUN;

/***Univariate Analysis of the continuous variable : LOAN_DURATION***/
TITLE 'Univariate Analysis of the Continuous Variable : LOAN_DURATION';

PROC MEANS DATA = LIBOCT34.TRAINING_DS N NMISS MIN MAX MEAN MEDIAN STD;

VAR LOAN_DURATION;

RUN;

ODS GRAPHICS / RESET WIDTH = 3.0 IN HEIGHT = 4.0 IN IMAGEMAP;

PROC SGPLOT DATA = LIBOCT34.TRAINING_DS;

HISTOGRAM LOAN_DURATION;

TITLE 'Univariate Analysis of the Continuous Variable : LOAN_DURATION';

RUN;

/* Univariate Analysis of the Categorical Variables using SAS MACRO */
OPTION MCOMPILENOTE=ALL;
%MACRO macro_uvacate_vari(pdataset_name,pcate_vari_name,ptitle_name);
TITLE &ptitle_name;

PROC FREQ DATA = &pdataset_name;

TABLE &pcate_vari_name;

RUN;
%MEND macro_uvacate_vari;

/* To call the SAS MACRO - macro_uvacate_vari */
%macro_uvacate_vari(LIBOCT34.TESTING_DS,LOAN_LOCATION, 'Univariate Analysis of the Categorical Variable - LOAN_LOCATION');
%macro_uvacate_vari(LIBOCT34.TESTING_DS,QUALIFICATION, 'Univariate Analysis of the Categorical Variable - QUALIFICATION');
%macro_uvacate_vari(LIBOCT34.TESTING_DS,LOAN_HISTORY, 'Univariate Analysis of the Categorical Variable - LOAN_HISTORY');
%macro_uvacate_vari(LIBOCT34.TESTING_DS,FAMILY_MEMBERS, 'Univariate Analysis of the Categorical Variable - FAMILY_MEMBERS');
%macro_uvacate_vari(LIBOCT34.TESTING_DS,MARITAL_STATUS, 'Univariate Analysis of the Categorical Variable - MARITAL_STATUS');
%macro_uvacate_vari(LIBOCT34.TESTING_DS,GENDER, 'Univariate Analysis of the Categorical Variable - GENDER');
%macro_uvacate_vari(LIBOCT34.TESTING_DS,EMPLOYMENT, 'Univariate Analysis of the Categorical Variable - EMPLOYMENT');

OPTION MCOMPILENOTE=ALL;
%MACRO UVA_CONTI_VARI(pds_name,pconti_vari_name,ptitle);

TITLE &ptitle;

PROC MEANS DATA = &pds_name N NMISS MIN MAX MEAN MEDIAN STD;
VAR &pconti_vari_name;
RUN;

%MEND UVA_CONTI_VARI;

/* To call the SAS MACRO - UVA_CONTI_VARI */
%UVA_CONTI_VARI(LIBOCT34.TESTING_DS,CANDIDATE_INCOME, 'Univariate Analysis of the Continuous Variable - CANDIDATE_INCOME');
%UVA_CONTI_VARI(LIBOCT34.TESTING_DS,GUARANTEE_INCOME, 'Univariate Analysis of the Continuous Variable - GUARANTEE_INCOME');
%UVA_CONTI_VARI(LIBOCT34.TESTING_DS,LOAN_AMOUNT, 'Univariate Analysis of the Continuous Variable - LOAN_AMOUNT');
%UVA_CONTI_VARI(LIBOCT34.TESTING_DS,LOAN_DURATION, 'Univariate Analysis of the Continuous Variable - LOAN_DURATION');

OPTION MCOMPILENOTE=ALL;
%MACRO BVA_CATE_CATE(pds_name,pcate_vari_name1,pcate_vari_name2,ptitle1,ptitle2);
TITLE1 &ptitle1;
TITLE2 &ptitle2;

PROC FREQ DATA = &pds_name;

TABLE &pcate_vari_name1 * &pcate_vari_name2/
PLOTS = FREQPLOT( TWOWAY = STACKED SCALE =GROUPPCT );

RUN;
%MEND BVA_CATE_CATE;

%BVA_CATE_CATE(LIBOCT34.TRAINING_DS,GENDER,FAMILY_MEMBERS,'Bivariate Analysis','GENDER vs FAMILY_MEMBERS');
%BVA_CATE_CATE(LIBOCT34.TRAINING_DS,QUALIFICATION,EMPLOYMENT,'Bivariate Analysis','QUALIFICATION vs EMPLOYMENT');
%BVA_CATE_CATE(LIBOCT34.TRAINING_DS,EMPLOYMENT,MARITAL_STATUS,'Bivariate Analysis','EMPLOYMENT vs MARITAL_STATUS');
%BVA_CATE_CATE(LIBOCT34.TRAINING_DS,EMPLOYMENT,LOAN_LOCATION,'Bivariate Analysis','EMPLOYMENT vs LOAN_LOCATION');

OPTIONS MCOMPILENOTE=ALL;
%MACRO BVA_CATE_CONTI(pds_name,pcate_vari_name,pconti_vari_name,ptitle1,ptitle2);
TITLE1 &ptitle1;
TITLE2 &ptitle2;

PROC MEANS DATA = &pds_name;

CLASS &pcate_vari_name; /* Is a Categorical Variable */
VAR &pconti_vari_name; /* Is a Continuous/Numerical Variable */

RUN;
%MEND BVA_CATE_CONTI;

%BVA_CATE_CONTI(LIBOCT34.TRAINING_DS,MARITAL_STATUS,LOAN_AMOUNT,'Bivariate Analysis','MARITAL_STATUS vs LOAN_AMOUNT');
%BVA_CATE_CONTI(LIBOCT34.TRAINING_DS,FAMILY_MEMBERS,LOAN_DURATION,'Bivariate Analysis','FAMILY_MEMBERS vs LOAN_DURATION');
%BVA_CATE_CONTI(LIBOCT34.TRAINING_DS,LOAN_LOCATION,CANDIDATE_INCOME,'Bivariate Analysis','LOAN_LOCATION vs CANDIDATE_INCOME');

OPTIONS MCOMPILENOTE=ALL;
%MACRO BVA_CATE_CATE(pds_name,pcate_vari_name1,pcate_vari_name2,ptitle1,ptitle2);
TITLE1 &ptitle1;
TITLE2 &ptitle2;

PROC FREQ DATA = &pds_name;

TABLE &pcate_vari_name1 * &pcate_vari_name2/
PLOTS = FREQPLOT( TWOWAY = STACKED SCALE =GROUPPCT );

RUN;
%MEND BVA_CATE_CATE;

%BVA_CATE_CATE(LIBOCT34.TESTING_DS,GENDER,FAMILY_MEMBERS,'Bivariate Analysis','GENDER vs FAMILY_MEMBERS');
%BVA_CATE_CATE(LIBOCT34.TESTING_DS,QUALIFICATION,EMPLOYMENT,'Bivariate Analysis','QUALIFICATION vs EMPLOYMENT');
%BVA_CATE_CATE(LIBOCT34.TESTING_DS,EMPLOYMENT,MARITAL_STATUS,'Bivariate Analysis','EMPLOYMENT vs MARITAL_STATUS');
%BVA_CATE_CATE(LIBOCT34.TESTING_DS,EMPLOYMENT,LOAN_LOCATION,'Bivariate Analysis','EMPLOYMENT vs LOAN_LOCATION');

OPTIONS MCOMPILENOTE=ALL;
%MACRO BVA_CATE_CONTI(pds_name,pcate_vari_name,pconti_vari_name,ptitle1,ptitle2);
TITLE1 &ptitle1;
TITLE2 &ptitle2;

PROC MEANS DATA = &pds_name;

CLASS &pcate_vari_name; /* Is a Categorical Variable */
VAR &pconti_vari_name; /* Is a Continuous/Numerical Variable */

RUN;
%MEND BVA_CATE_CONTI;

%BVA_CATE_CONTI(LIBOCT34.TESTING_DS,MARITAL_STATUS,LOAN_AMOUNT,'Bivariate Analysis','MARITAL_STATUS vs LOAN_AMOUNT');
%BVA_CATE_CONTI(LIBOCT34.TESTING_DS,FAMILY_MEMBERS,LOAN_DURATION,'Bivariate Analysis','FAMILY_MEMBERS vs LOAN_DURATION');
%BVA_CATE_CONTI(LIBOCT34.TESTING_DS,LOAN_LOCATION,CANDIDATE_INCOME,'Bivariate Analysis','LOAN_LOCATION vs CANDIDATE_INCOME');

TITLE1 'STEP 1 : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their MARITAL_STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS e
WHERE (e.marital_status eq '' or e.marital_status IS MISSING);

QUIT;

TITLE1 'STEP 2 : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their MIRITAL_STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TRAINING_DS e
WHERE (e.marital_status eq '' or e.marital_status IS MISSING);

QUIT;

/* STEP 3 : Extract the statistic and save it in a temporary dataset'*/

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_STAT_DS AS
SELECT e.marital_status AS marital_status_name, 
			   COUNT(*) AS counts
FROM LIBOCT34.TRAINING_DS e
WHERE (e.marital_status ne '' or e.marital_status IS NOT MISSING)
GROUP BY e.marital_status;

QUIT;

/* STEP 4 : Find the MOD value */

PROC SQL;

SELECT tso.marital_status_name AS marital_status_name
FROM LIBOCT34.TRAINING_STAT_DS tso
WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  FROM LIBOCT34.TRAINING_STAT_DS tsi );
					/*The above sub-program is to find the highest count */

QUIT;

/* STEP 4.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_BK_DS AS
SELECT *
FROM LIBOCT34.TRAINING_DS;

QUIT;

/* STEP 4.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_DS AS
SELECT *
FROM LIBOCT34.TRAINING_BK_DS;

QUIT;

/* STEP 5 : Impute the missing values found in the Categorical Variable _MARITAL_STATUS */

PROC SQL;

UPDATE LIBOCT34.TRAINING_DS
SET marital_status = ( SELECT tso.marital_status_name AS marital_status_name
					   FROM LIBOCT34.TRAINING_STAT_DS tso
					   WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  						 FROM LIBOCT34.TRAINING_STAT_DS tsi ) )
											 /*The above sub-program is to find the highest count */
WHERE ( marital_status eq '' or marital_status IS MISSING );

QUIT;

TITLE1 'STEP 6 (After Imputation) : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their MIRITAL_STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS e
WHERE (e.marital_status eq '' or e.marital_status IS MISSING);

QUIT;

TITLE1 'STEP 7 (After Imputation) : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their MIRITAL_STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TRAINING_DS e
WHERE (e.marital_status eq '' or e.marital_status IS MISSING);
QUIT;

TITLE 'STEP 1 : List the details of the Loan Applicants who submitted their loan applications without stating their family members data';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.family_members IS MISSING ) OR 
		( t.family_members eq '' ) );

QUIT;

TITLE1 'STEP 2 : Count the total number of the Loan Applicants who submitted their loan applications without stating their family members data';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.family_members IS MISSING ) OR 
		( t.family_members eq '' ) );
QUIT;

/* STEP 2.1 : BACKUP COPY */
PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_BK_DS AS
SELECT *
FROM LIBOCT34.TRAINING_DS;

QUIT;

/* STEP 2.2 : RESTORING BACKUP COPY */
PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_DS AS
SELECT *
FROM LIBOCT34.TRAINING_BK_DS;

QUIT;

/* STEP 3 : Remove the "+" symbol found in the FAMILY_MEMBERS variable data */
PROC SQL;

UPDATE LIBOCT34.TRAINING_DS
SET FAMILY_MEMBERS = SUBSTR(FAMILY_MEMBERS,1,1);

QUIT;

/* STEP 4 : Find the statistics and save the statistics in a temporary dataset */
PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_STATS_DS AS 
SELECT t.FAMILY_MEMBERS AS Family_Members,
COUNT(*) AS Counts
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.FAMILY_MEMBERS IS NOT MISSING ) OR
	    ( t.FAMILY_MEMBERS ne '') )
GROUP BY t.FAMILY_MEMBERS;
	  
QUIT;

/* STEP 5 : Find the MOD value */
PROC SQL;

SELECT to.FAMILY_MEMBERS AS Family_Members
FROM LIBOCT34.TRAINING_STATS_DS to
WHERE Counts eq ( SELECT MAX(ti.Counts) AS Highest_Counts
				  FROM LIBOCT34.TRAINING_STATS_DS ti ); 
				  /* This is a sub-program to find the highest Count */
	  
QUIT;

/* STEP 5.1 : BACKUP COPY */
PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_BK_DS AS
SELECT *
FROM LIBOCT34.TRAINING_DS;

QUIT;

/* STEP 6 : Impute the missing values fouund in the categorical variable - FAMILY_MEMBERS */
PROC SQL;

UPDATE LIBOCT34.TRAINING_DS
SET FAMILY_MEMBERS = (
						SELECT to.FAMILY_MEMBERS AS Family_Members
						FROM LIBOCT34.TRAINING_STATS_DS to
						WHERE Counts eq ( SELECT MAX(ti.Counts) AS Highest_Counts
				  						  FROM LIBOCT34.TRAINING_STATS_DS ti ) )
				  						  /* This is a sub-program to find the highest Count */

WHERE ( ( family_members IS MISSING ) OR 
		( family_members eq '' ) );
QUIT;

TITLE1 'STEP 1 : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their GENDER';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS e
WHERE (e.gender eq '' or e.gender IS MISSING);

QUIT;

TITLE1 'STEP 2 : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their GENDER';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TRAINING_DS e
WHERE (e.gender eq '' or e.gender IS MISSING);

QUIT;

/* STEP 3 : Extract the statistic and save it in a temporary dataset'*/

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_STAT_DS AS
SELECT e.gender AS gender_name, 
			   COUNT(*) AS counts
FROM LIBOCT34.TRAINING_DS e
WHERE (e.gender ne '' or e.gender IS NOT MISSING)
GROUP BY e.gender;

QUIT;

/* STEP 4 : Find the MOD value */

PROC SQL;

SELECT tso.gender_name AS gender_name
FROM LIBOCT34.TRAINING_STAT_DS tso
WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  FROM LIBOCT34.TRAINING_STAT_DS tsi );
					/*The above sub-program is to find the highest count */

QUIT;

/* STEP 4.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_BK_DS AS
SELECT *
FROM LIBOCT34.TRAINING_DS;

QUIT;

/* STEP 4.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_DS AS
SELECT *
FROM LIBOCT34.TRAINING_BK_DS;

QUIT;

/* STEP 5 : Impute the missing values found in the Categorical Variable GENDER */

PROC SQL;

UPDATE LIBOCT34.TRAINING_DS
SET gender = ( SELECT tso.gender_name AS gender_name
					   FROM LIBOCT34.TRAINING_STAT_DS tso
					   WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  						 FROM LIBOCT34.TRAINING_STAT_DS tsi ) )
											 /*The above sub-program is to find the highest count */
WHERE ( gender eq '' or gender IS MISSING );

QUIT;

TITLE1 'STEP 6 (After Imputation) : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their GENDER';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS e
WHERE (e.gender eq '' or e.gender IS MISSING);

QUIT;

TITLE1 'STEP 7 (After Imputation) : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their GENDER';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TRAINING_DS e
WHERE (e.gender eq '' or e.gender IS MISSING);
QUIT;

TITLE1 'STEP 1 : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their EMPLOYMENT STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS e
WHERE (e.employment eq '' or e.employment IS MISSING);

QUIT;

TITLE1 'STEP 2 : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their EMPLOYMENT STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TRAINING_DS e
WHERE (e.employment eq '' or e.employment IS MISSING);

QUIT;

/* STEP 3 : Extract the statistic and save it in a temporary dataset'*/

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_STAT_DS AS
SELECT e.employment AS employment_name, 
			   COUNT(*) AS counts
FROM LIBOCT34.TRAINING_DS e
WHERE (e.employment ne '' or e.employment IS NOT MISSING)
GROUP BY e.employment;

QUIT;

/* STEP 4 : Find the MOD value */

PROC SQL;

SELECT tso.employment_name AS employment_name
FROM LIBOCT34.TRAINING_STAT_DS tso
WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  FROM LIBOCT34.TRAINING_STAT_DS tsi );
					/*The above sub-program is to find the highest count */

QUIT;

/* STEP 4.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_BK_DS AS
SELECT *
FROM LIBOCT34.TRAINING_DS;

QUIT;

/* STEP 4.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_DS AS
SELECT *
FROM LIBOCT34.TRAINING_BK_DS;

QUIT;

/* STEP 5 : Impute the missing values found in the Categorical Variable EMPLOYMENT STATUS */

PROC SQL;

UPDATE LIBOCT34.TRAINING_DS
SET employment = ( SELECT tso.employment_name AS employment_name
					   FROM LIBOCT34.TRAINING_STAT_DS tso
					   WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  						 FROM LIBOCT34.TRAINING_STAT_DS tsi ) )
											 /*The above sub-program is to find the highest count */
WHERE ( employment eq '' or employment IS MISSING );

QUIT;

TITLE1 'STEP 6 (After Imputation) : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their EMPLOYMENT STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS e
WHERE (e.employment eq '' or e.employment IS MISSING);

QUIT;

TITLE1 'STEP 7 (After Imputation) : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their EMPLOYMENT STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TRAINING_DS e
WHERE (e.employment eq '' or e.employment IS MISSING);
QUIT;

TITLE1 'STEP 1 : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their LOAN_HISTORY';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS e
WHERE (e.loan_history eq . or e.loan_history IS MISSING);

QUIT;

TITLE1 'STEP 2 : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their LOAN_HISTORY';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TRAINING_DS e
WHERE (e.loan_history eq . or e.loan_history IS MISSING);

QUIT;

/* STEP 3 : Extract the statistic and save it in a temporary dataset'*/

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_STAT_DS AS
SELECT e.loan_history AS loan_history_name, 
			   COUNT(*) AS counts
FROM LIBOCT34.TRAINING_DS e
WHERE (e.loan_history ne . or e.loan_history IS NOT MISSING)
GROUP BY e.loan_history;

QUIT;

/* STEP 4 : Find the MOD value */

PROC SQL;

SELECT tso.loan_history_name AS loan_history_name
FROM LIBOCT34.TRAINING_STAT_DS tso
WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  FROM LIBOCT34.TRAINING_STAT_DS tsi );
					/*The above sub-program is to find the highest count */

QUIT;

/* STEP 4.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_BK_DS AS
SELECT *
FROM LIBOCT34.TRAINING_DS;

QUIT;

/* STEP 4.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_DS AS
SELECT *
FROM LIBOCT34.TRAINING_BK_DS;

QUIT;

/* STEP 5 : Impute the missing values found in the Categorical Variable LOAN_HISTORY */

PROC SQL;

UPDATE LIBOCT34.TRAINING_DS
SET loan_history = ( SELECT tso.loan_history_name AS loan_history_name
					   FROM LIBOCT34.TRAINING_STAT_DS tso
					   WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  						 FROM LIBOCT34.TRAINING_STAT_DS tsi ) )
											 /*The above sub-program is to find the highest count */
WHERE ( loan_history eq . or loan_history IS MISSING );

QUIT;

TITLE1 'STEP 6 (After Imputation) : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their LOAN_HISTORY';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS e
WHERE (e.loan_history eq . or e.loan_history IS MISSING);

QUIT;

TITLE1 'STEP 7 (After Imputation) : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their LOAN_HISTORY';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TRAINING_DS e
WHERE (e.loan_history eq . or e.loan_history IS MISSING);
QUIT;

/***********************************************IMPUTATION CONTINUOUS VARIABLES [TRAINING_DS]****************************************************************/
TITLE1 'STEP 1 : List the details of the loan applicant who submitted their loan applications without stating their LOAN_DURATION';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.loan_duration IS MISSING ) OR 
		( t.loan_duration eq . ) );

QUIT;

TITLE1 'STEP 2 : Count the total number of the loan applicant who submitted their loan applications without stating their LOAN_DURATION';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.loan_duration IS MISSING ) OR 
		( t.loan_duration eq . ) );

QUIT;

/* STEP 2.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_BK_DS AS
SELECT *
FROM LIBOCT34.TRAINING_DS;

QUIT;

/* STEP 2.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_DS AS
SELECT *
FROM LIBOCT34.TRAINING_BK_DS;

QUIT;

/* STEP 3 : Impute the missing values found in the Continuous Variable - LOAN_DURATION */

PROC STDIZE DATA = LIBOCT34.TRAINING_DS REPONLY

METHOD = MEAN OUT = LIBOCT34.TRAINING_DS;
VAR loan_duration;

QUIT;

TITLE1 'STEP 4 : List the details of the loan applicant who submitted their loan applications without stating their LOAN_DURATION';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.loan_duration IS MISSING ) OR 
		( t.loan_duration eq . ) );

QUIT;

TITLE1 'STEP 5 : Count the total number of the loan applicant who submitted their loan applications without stating their LOAN_DURATION';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.loan_duration IS MISSING ) OR 
		( t.loan_duration eq . ) );

QUIT;

TITLE1 'STEP 1 : List the details of the loan applicant who submitted their loan applications without stating their LOAN_AMOUNT';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.loan_amount IS MISSING ) OR 
		( t.loan_amount eq . ) );

QUIT;

TITLE1 'STEP 2 : Count the total number of the loan applicant who submitted their loan applications without stating their LOAN_AMOUNT';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.loan_amount IS MISSING ) OR 
		( t.loan_amount eq . ) );

QUIT;

/* STEP 2.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_BK_DS AS
SELECT *
FROM LIBOCT34.TRAINING_DS;

QUIT;

/* STEP 2.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TRAINING_DS AS
SELECT *
FROM LIBOCT34.TRAINING_BK_DS;

QUIT;

/* STEP 3 : Impute the missing values found in the Continuous Variable - LOAN_AMOUNT */

PROC STDIZE DATA = LIBOCT34.TRAINING_DS REPONLY

METHOD = MEAN OUT = LIBOCT34.TRAINING_DS;
VAR loan_amount;

QUIT;

TITLE1 'STEP 4 : List the details of the loan applicant who submitted their loan applications without stating their LOAN_AMOUNT';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.loan_amount IS MISSING ) OR 
		( t.loan_amount eq . ) );

QUIT;

TITLE1 'STEP 5 : Count the total number of the loan applicant who submitted their loan applications without stating their LOAN_AMOUNT';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TRAINING_DS t
WHERE ( ( t.loan_amount IS MISSING ) OR 
		( t.loan_amount eq . ) );

QUIT;


/*******************************************************CATEGORICAL VARIABLE IMPUTATION [TESTING_DS]******************************************************************/
TITLE 'STEP 1 : List the details of the Loan Applicants who submitted their loan applications without stating their FAMILY_MEMBERS data';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.family_members IS MISSING ) OR 
		( t.family_members eq '' ) );

QUIT;

TITLE 'STEP 2 : Count the total number of the Loan Applicants who submitted their loan applications without stating their FAMILY_MEMBERS data';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.family_members IS MISSING ) OR 
		( t.family_members eq '' ) );
QUIT;

/* STEP 2.1 : BACKUP COPY */
PROC SQL;

CREATE TABLE LIBOCT34.TESTING_BK_DS AS
SELECT *
FROM LIBOCT34.TESTING_DS;

QUIT;

/* STEP 2.2 : RESTORING BACKUP COPY */
PROC SQL;

CREATE TABLE LIBOCT34.TESTING_DS AS
SELECT *
FROM LIBOCT34.TESTING_BK_DS;

QUIT;

/* STEP 3 : Remove the "+" symbol found in the FAMILY_MEMBERS variable data */
PROC SQL;

UPDATE LIBOCT34.TESTING_DS
SET FAMILY_MEMBERS = SUBSTR(FAMILY_MEMBERS,1,1);

QUIT;

/* STEP 4 : Find the statistics and save the statistics in a temporary dataset */
PROC SQL;

CREATE TABLE LIBOCT34.TESTING_STATS_DS AS 
SELECT t.FAMILY_MEMBERS AS Family_Members,
COUNT(*) AS Counts
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.FAMILY_MEMBERS IS NOT MISSING ) OR
	    ( t.FAMILY_MEMBERS ne '') )
GROUP BY t.FAMILY_MEMBERS;
	  
QUIT;

/* STEP 5 : Find the MOD value */
PROC SQL;

SELECT to.FAMILY_MEMBERS AS Family_Members
FROM LIBOCT34.TESTING_STATS_DS to
WHERE Counts eq ( SELECT MAX(ti.Counts) AS Highest_Counts
				  FROM LIBOCT34.TESTING_STATS_DS ti ); 
				  /* This is a sub-program to find the highest Count */
	  
QUIT;

/* STEP 5.1 : BACKUP COPY */
PROC SQL;

CREATE TABLE LIBOCT34.TESTING_BK_DS AS
SELECT *
FROM LIBOCT34.TESTING_DS;

QUIT;

/* STEP 6 : Impute the missing values found in the categorical variable - FAMILY_MEMBERS */
PROC SQL;

UPDATE LIBOCT34.TESTING_DS
SET FAMILY_MEMBERS = (
						SELECT to.FAMILY_MEMBERS AS Family_Members
						FROM LIBOCT34.TESTING_STATS_DS to
						WHERE Counts eq ( SELECT MAX(ti.Counts) AS Highest_Counts
				  						  FROM LIBOCT34.TESTING_STATS_DS ti ) )
				  						  /* This is a sub-program to find the highest Count */

WHERE ( ( family_members IS MISSING ) OR 
		( family_members eq '' ) );
QUIT;

TITLE1 'STEP 1 : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their LOAN_HISTORY';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS e
WHERE (e.loan_history eq . or e.loan_history IS MISSING);

QUIT;

TITLE1 'STEP 2 : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their LOAN_HISTORY';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TESTING_DS e
WHERE (e.loan_history eq . or e.loan_history IS MISSING);

QUIT;

/* STEP 3 : Extract the statistic and save it in a temporary dataset'*/

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_STAT_DS AS
SELECT e.loan_history AS loan_history_name, 
			   COUNT(*) AS counts
FROM LIBOCT34.TESTING_DS e
WHERE (e.loan_history ne . or e.loan_history IS NOT MISSING)
GROUP BY e.loan_history;

QUIT;

/* STEP 4 : Find the MOD value */

PROC SQL;

SELECT tso.loan_history_name AS loan_history_name
FROM LIBOCT34.TESTING_STAT_DS tso
WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  FROM LIBOCT34.TESTING_STAT_DS tsi );
					/*The above sub-program is to find the highest count */

QUIT;

/* STEP 4.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_BK_DS AS
SELECT *
FROM LIBOCT34.TESTING_DS;

QUIT;

/* STEP 4.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_DS AS
SELECT *
FROM LIBOCT34.TESTING_BK_DS;

QUIT;

/* STEP 5 : Impute the missing values found in the Categorical Variable LOAN_HISTORY */

PROC SQL;

UPDATE LIBOCT34.TESTING_DS
SET loan_history = ( SELECT tso.loan_history_name AS loan_history_name
					   FROM LIBOCT34.TESTING_STAT_DS tso
					   WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  						 FROM LIBOCT34.TESTING_STAT_DS tsi ) )
											 /*The above sub-program is to find the highest count */
WHERE ( loan_history eq . or loan_history IS MISSING );

QUIT;

TITLE1 'STEP 6 (After Imputation) : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their LOAN_HISTORY';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS e
WHERE (e.loan_history eq . or e.loan_history IS MISSING);

QUIT;

TITLE1 'STEP 7 (After Imputation) : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their LOAN_HISTORY';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TESTING_DS e
WHERE (e.loan_history eq . or e.loan_history IS MISSING);
QUIT;

TITLE1 'STEP 1 : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their GENDER';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS e
WHERE (e.gender eq '' or e.gender IS MISSING);

QUIT;

TITLE1 'STEP 2 : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their GENDER';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TESTING_DS e
WHERE (e.gender eq '' or e.gender IS MISSING);

QUIT;

/* STEP 3 : Extract the statistic and save it in a temporary dataset'*/

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_STAT_DS AS
SELECT e.gender AS gender_name, 
			   COUNT(*) AS counts
FROM LIBOCT34.TESTING_DS e
WHERE (e.gender ne '' or e.gender IS NOT MISSING)
GROUP BY e.gender;

QUIT;

/* STEP 4 : Find the MOD value */

PROC SQL;

SELECT tso.gender_name AS gender_name
FROM LIBOCT34.TESTING_STAT_DS tso
WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  FROM LIBOCT34.TESTING_STAT_DS tsi );
					/*The above sub-program is to find the highest count */

QUIT;

/* STEP 4.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_BK_DS AS
SELECT *
FROM LIBOCT34.TESTING_DS;

QUIT;

/* STEP 4.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_DS AS
SELECT *
FROM LIBOCT34.TESTING_BK_DS;

QUIT;

/* STEP 5 : Impute the missing values found in the Categorical Variable GENDER */

PROC SQL;

UPDATE LIBOCT34.TESTING_DS
SET gender = ( SELECT tso.gender_name AS gender_name
					   FROM LIBOCT34.TESTING_STAT_DS tso
					   WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  						 FROM LIBOCT34.TESTING_STAT_DS tsi ) )
											 /*The above sub-program is to find the highest count */
WHERE ( gender eq '' or gender IS MISSING );

QUIT;

TITLE1 'STEP 6 (After Imputation) : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their GENDER';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS e
WHERE (e.gender eq '' or e.gender IS MISSING);

QUIT;

TITLE1 'STEP 7 (After Imputation) : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their GENDER';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TESTING_DS e
WHERE (e.gender eq '' or e.gender IS MISSING);
QUIT;

TITLE1 'STEP 1 : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their EMPLOYMENT STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS e
WHERE (e.employment eq '' or e.employment IS MISSING);

QUIT;

TITLE1 'STEP 2 : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their EMPLOYMENT STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TESTING_DS e
WHERE (e.employment eq '' or e.employment IS MISSING);

QUIT;

/* STEP 3 : Extract the statistic and save it in a temporary dataset'*/

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_STAT_DS AS
SELECT e.employment AS employment_name, 
			   COUNT(*) AS counts
FROM LIBOCT34.TESTING_DS e
WHERE (e.employment ne '' or e.employment IS NOT MISSING)
GROUP BY e.employment;

QUIT;

/* STEP 4 : Find the MOD value */

PROC SQL;

SELECT tso.employment_name AS employment_name
FROM LIBOCT34.TESTING_STAT_DS tso
WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  FROM LIBOCT34.TESTING_STAT_DS tsi );
					/*The above sub-program is to find the highest count */

QUIT;

/* STEP 4.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_BK_DS AS
SELECT *
FROM LIBOCT34.TESTING_DS;

QUIT;

/* STEP 4.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_DS AS
SELECT *
FROM LIBOCT34.TESTING_BK_DS;

QUIT;

/* STEP 5 : Impute the missing values found in the Categorical Variable EMPLOYMENT STATUS */

PROC SQL;

UPDATE LIBOCT34.TESTING_DS
SET employment = ( SELECT tso.employment_name AS employment_name
					   FROM LIBOCT34.TESTING_STAT_DS tso
					   WHERE tso.counts eq ( SELECT MAX(tsi.counts) AS highest_counts
				  	  						 FROM LIBOCT34.TESTING_STAT_DS tsi ) )
											 /*The above sub-program is to find the highest count */
WHERE ( employment eq '' or employment IS MISSING );

QUIT;

TITLE1 'STEP 6 (After Imputation) : List the details of the loan applicants';
TITLE2 'who submitted their loan application without stating their EMPLOYMENT STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS e
WHERE (e.employment eq '' or e.employment IS MISSING);

QUIT;

TITLE1 'STEP 7 (After Imputation) : Count the numbers of the loan applicants';
TITLE2 'who submitted their loan application without stating their EMPLOYMENT STATUS';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Counts'
FROM LIBOCT34.TESTING_DS e
WHERE (e.employment eq '' or e.employment IS MISSING);
QUIT;

/*******************************************************CONTINUOUS VARIABLE IMPUTATION [TESTING_DS]******************************************************************/
TITLE1 'STEP 1 : List the details of the loan applicant who submitted their loan applications without stating their LOAN_DURATION';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.loan_duration IS MISSING ) OR 
		( t.loan_duration eq . ) );

QUIT;

TITLE1 'STEP 2 : Count the total number of the loan applicant who submitted their loan applications without stating their LOAN_DURATION';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.loan_duration IS MISSING ) OR 
		( t.loan_duration eq . ) );

QUIT;

/* STEP 2.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_BK_DS AS
SELECT *
FROM LIBOCT34.TESTING_DS;

QUIT;

/* STEP 2.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_DS AS
SELECT *
FROM LIBOCT34.TESTING_BK_DS;

QUIT;

/* STEP 3 : Impute the missing values found in the Continuous Variable - LOAN_DURATION */

PROC STDIZE DATA = LIBOCT34.TESTING_DS REPONLY

METHOD = MEAN OUT = LIBOCT34.TESTING_DS;
VAR loan_duration;

QUIT;

TITLE1 'STEP 4 : List the details of the loan applicant who submitted their loan applications without stating their LOAN_DURATION';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.loan_duration IS MISSING ) OR 
		( t.loan_duration eq . ) );

QUIT;

TITLE1 'STEP 5 : Count the total number of the loan applicant who submitted their loan applications without stating their LOAN_DURATION';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.loan_duration IS MISSING ) OR 
		( t.loan_duration eq . ) );

QUIT;

TITLE1 'STEP 1 : List the details of the loan applicant who submitted their loan applications without stating their LOAN_AMOUNT';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.loan_amount IS MISSING ) OR 
		( t.loan_amount eq . ) );

QUIT;

TITLE1 'STEP 2 : Count the total number of the loan applicant who submitted their loan applications without stating their LOAN_AMOUNT';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.loan_amount IS MISSING ) OR 
		( t.loan_amount eq . ) );

QUIT;

/* STEP 2.1 : BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_BK_DS AS
SELECT *
FROM LIBOCT34.TESTING_DS;

QUIT;

/* STEP 2.2 : RESTORING BACKUP COPY */

PROC SQL;

CREATE TABLE LIBOCT34.TESTING_DS AS
SELECT *
FROM LIBOCT34.TESTING_BK_DS;

QUIT;

/* STEP 3 : Impute the missing values found in the Continuous Variable - LOAN_AMOUNT */

PROC STDIZE DATA = LIBOCT34.TESTING_DS REPONLY

METHOD = MEAN OUT = LIBOCT34.TESTING_DS;
VAR loan_amount;

QUIT;

TITLE1 'STEP 4 : List the details of the loan applicant who submitted their loan applications without stating their LOAN_AMOUNT';
FOOTNOTE '------END------';

PROC SQL;

SELECT *
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.loan_amount IS MISSING ) OR 
		( t.loan_amount eq . ) );

QUIT;

TITLE1 'STEP 5 : Count the total number of the loan applicant who submitted their loan applications without stating their LOAN_AMOUNT';
FOOTNOTE '------END------';

PROC SQL;

SELECT COUNT(*) LABEL = 'Number of Loan Applicants'
FROM LIBOCT34.TESTING_DS t
WHERE ( ( t.loan_amount IS MISSING ) OR 
		( t.loan_amount eq . ) );

QUIT;


/**************************************************************VERIFICATION ON BOTH DATASETS******************************************************************************/

TITLE 'Find the Categorical Variables of LIBOCT34.TRAINING_DS that still with missing values';
PROC FORMAT;
	VALUE $missfmt ' ' = 'Total number of observations with missing values' others = 'Total number of observations without missing values';
RUN;

PROC FREQ DATA =LIBOCT34.TRAINING_DS;
	FORMAT _CHAR_ $missfmt.;
	TABLE _CHAR_ / missing nocum nopercent;
RUN;

TITLE 'Find the Categorical Variables of LIBOCT34.TESTING_DS that still with missing values';
PROC FORMAT;
	VALUE $missfmt ' ' = 'Total number of observations with missing values' others = 'Total number of observations without missing values';
RUN;

PROC FREQ DATA =LIBOCT34.TESTING_DS;
	FORMAT _CHAR_ $missfmt.;
	TABLE _CHAR_ / missing nocum nopercent;
RUN;

TITLE 'Find the Continuous Variables of LIBOCT34.TRAINING_DS that still with missing values';
PROC FORMAT;
	VALUE missfmt .  = 'Total number of observations with missing values' others = 'Total number of observations without missing values';
RUN;

PROC FREQ DATA =LIBOCT34.TRAINING_DS;
	FORMAT _NUMERIC_ missfmt. ;
	TABLE _NUMERIC_ / missing nocum nopercent;
RUN;

TITLE 'Find the Continuous Variables of LIBOCT34.TESTING_DS that still with missing values';
PROC FORMAT;
	VALUE missfmt .  = 'Total number of observations with missing values' others = 'Total number of observations without missing values';
RUN;

PROC FREQ DATA =LIBOCT34.TESTING_DS;
	FORMAT _NUMERIC_ missfmt. ;
	TABLE _NUMERIC_ / missing nocum nopercent;
RUN;

/* Creation if a model using Logistic Regression algorithm */
PROC LOGISTIC DATA = LIBOCT34.TRAINING_DS OUTMODEL = LIBOCT34.TRAINING_DS_LR_MODEL;
CLASS
	LOAN_HISTORY
	LOAN_LOCATION
	MARITAL_STATUS
	FAMILY_MEMBERS
	GENDER
	QUALIFICATION
	EMPLOYMENT
	;

MODEL LOAN_APPROVAL_STATUS =
	  LOAN_HISTORY
	  LOAN_LOCATION
	  LOAN_AMOUNT
	  LOAN_DURATION
	  MARITAL_STATUS
	  FAMILY_MEMBERS
	  GENDER
	  QUALIFICATION
	  EMPLOYMENT
	  CANDIDATE_INCOME
	  GUARANTEE_INCOME
	  ;
OUTPUT OUT = LIBOCT34.TRAINING_OUT_DS P = PPRED_PROB;

RUN;

/**********************************************************************************************************
Predict the loan approval status using LR model created
***********************************************************************************************************/
PROC LOGISTIC INMODEL = LIBOCT34.TRAINING_DS_LR_MODEL; /*created model*/

SCORE DATA = LIBOCT34.TESTING_DS /*testing dataset*/
OUT = LIBOCT34.TESTING_LAS_PREDICTED_DS; /*location of output*/

QUIT;

/*Extracting Metadata*/
PROC CONTENTS DATA = LIBOCT34.TESTING_LAS_PREDICTED_DS;

RUN;

/*******************************Generate Simple report****************************************************/
ODS PDF FILE = "/home/u63933407/DAP_FT_OCT_2024_TP081634/MY_LAS_REPORT.pdf";
PROC PRINT DATA = LIBOCT34.TESTING_LAS_PREDICTED_DS;
RUN;
ODS PDF CLOSE;

ODS PDF CLOSE;
ODS PDF FILE = "/home/u63933407/DAP_FT_OCT_2024_TP081634/MY_LAS_REPORT2.pdf";
OPTIONS NODATE;
TITLE1 'Bank Loan Approval Status Predicted';
TITLE2 'APU,TPM';
PROC REPORT DATA= LIBOCT34.TESTING_LAS_PREDICTED_DS NOWINDOWS;
BY SME_LOAN_ID_NO;
DEFINE SME_LOAN_ID_NO /GROUP 'LOAN ID';
DEFINE GENDER /GROUP 'GENDER NAME';
DEFINE MARITAL_STATUS /GROUP 'MARITAL STATUS';
DEFINE FAMILY_MMEBERS /GROUP 'FAMILY MEMBERS';
DEFINE CANDIDATE_INCOME /GROUP 'CANDIDATE INCOME';
DEFINE GUARANTEE_INCOME /GROUP 'GUARANTEE INCOME';
DEFINE LOAN_AMOUNT /GROUP 'LOAN AMOUNT';
DEFINE LOAN_DURATION /GROUP 'LOAN DURATION';
DEFINE LOAN_HISTORY /GROUP 'LOAN HISTORY';
DEFINE LOAN_LOCATION /GROUP 'LOAN LOCATION';
FOOTNOTE '-------END OF REPORT-------';
RUN;
ODS PDF CLOSE;

/* Report Generation Begins Here
Generating a Complex Report Using LET (User Defined Variable Initialization)
SAS Macro, IF ELSE IF THEN Conditions */
OPTIONS MCOMPILENOTE = ALL
%MACRO MACRO_CR1(ploan_location);

%IF &ploan_location = "CITY" %THEN
%DO;
	%IF %SYSFUNC(EXIST(LIBOCT34.TESTING_LAS_CITY_DS)) %THEN	
	%DO;
		PROC SQL;
			DROP TABLE LIBOCT34.TESTING_LAS_CITY_DS;
		RUN;
	%END;
	PROC SQL;
		CREATE TABLE LIBOCT34.TESTING_LAS_CITY_DS AS
		SELECT l.sme_loan_id_no AS Loan_Id,
		CASE WHEN UPCASE(l.gender) = 'MALE' THEN 'M'
			 WHEN UPCASE(l.gender) = 'FEMALE' THEN 'F'
			 ELSE 'N/A'
		END AS Gender_short_name, /* User defined variable */
		CASE WHEN UPCASE(l.gender) = 'MALE' AND l.loan_history = 1 THEN
		'He is a good applicant and has settled his past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'MALE' AND l.loan_history = 0 THEN
		'He is not a good applicant and has not settled his past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'FEMALE' AND l.loan_history = 1 THEN
		'She is a good applicant and has settled her past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'FEMALE' AND l.loan_history = 0 THEN
		'She is not a good applicant and has not settled her past loan(s) on time'
			ELSE 'N/A'
		 END AS Remarks /* User defined variable */
		 FROM LIBOCT34.TESTING_LAS_PREDICTED_DS l
		 WHERE UPCASE(l.loan_location) = &ploan_location;
	RUN;
	
	TITLE1 'Complex report' &SYSDATE;
	TITLE2 'Details of the loan Applicants connected to ' &ploan_location;
	PROC PRINT DATA = LIBOCT34.TESTING_LAS_CITY_DS;
		VAR Loan_Id Gender_short_name Remarks;
	RUN;
%END;

%ELSE %IF &ploan_location = "VILLAGE" %THEN
%DO;
	%IF %SYSFUNC(EXIST(LIBOCT34.TESTING_LAS_VILLAGE_DS)) %THEN	
	%DO;
		PROC SQL;
			DROP TABLE LIBOCT34.TESTING_LAS_VILLAGE_DS;
		RUN;
	%END;
	PROC SQL;
		CREATE TABLE LIBOCT34.TESTING_LAS_VILLAGE_DS AS
		SELECT l.sme_loan_id_no AS Loan_Id,
		CASE WHEN UPCASE(l.gender) = 'MALE' THEN 'M'
			 WHEN UPCASE(l.gender) = 'FEMALE' THEN 'F'
			 ELSE 'N/A'
		END AS Gender_short_name, /* User defined variable */
		CASE WHEN UPCASE(l.gender) = 'MALE' AND l.loan_history = 1 THEN
		'He is a good applicant and has settled his past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'MALE' AND l.loan_history = 0 THEN
		'He is not a good applicant and has not settled his past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'FEMALE' AND l.loan_history = 1 THEN
		'She is a good applicant and has settled her past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'FEMALE' AND l.loan_history = 0 THEN
		'She is not a good applicant and has not settled her past loan(s) on time'
			ELSE 'N/A'
		 END AS Remarks /* User defined variable */
		 FROM LIBOCT34.TESTING_LAS_PREDICTED_DS l
		 WHERE UPCASE(l.loan_location) = &ploan_location;
	RUN;
	
	TITLE1 'Complex report' &SYSDATE;
	TITLE2 'Details of the loan Applicants connected to ' &ploan_location;
	PROC PRINT DATA = LIBOCT34.TESTING_LAS_VILLAGE_DS;
		VAR Loan_Id Gender_short_name Remarks;
	RUN;
%END;

%ELSE %IF &ploan_location = "TOWN" %THEN
%DO;
	%IF %SYSFUNC(EXIST(LIBOCT34.TESTING_LAS_TOWN_DS)) %THEN	
	%DO;
		PROC SQL;
			DROP TABLE LIBOCT34.TESTING_LAS_TOWN_DS;
		RUN;
	%END;
	PROC SQL;
		CREATE TABLE LIBOCT34.TESTING_LAS_TOWN_DS AS
		SELECT l.sme_loan_id_no AS Loan_Id,
		CASE WHEN UPCASE(l.gender) = 'MALE' THEN 'M'
			 WHEN UPCASE(l.gender) = 'FEMALE' THEN 'F'
			 ELSE 'N/A'
		END AS Gender_short_name, /* User defined variable */
		CASE WHEN UPCASE(l.gender) = 'MALE' AND l.loan_history = 1 THEN
		'He is a good applicant and has settled his past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'MALE' AND l.loan_history = 0 THEN
		'He is not a good applicant and has not settled his past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'FEMALE' AND l.loan_history = 1 THEN
		'She is a good applicant and has settled her past loan(s) on time'
			 WHEN UPCASE(l.gender) = 'FEMALE' AND l.loan_history = 0 THEN
		'She is not a good applicant and has not settled her past loan(s) on time'
			ELSE 'N/A'
		 END AS Remarks /* User defined variable */
		 FROM LIBOCT34.TESTING_LAS_PREDICTED_DS l
		 WHERE UPCASE(l.loan_location) = &ploan_location;
	RUN;
	
	TITLE1 'Complex report' &SYSDATE;
	TITLE2 'Details of the loan Applicants connected to ' &ploan_location;
	PROC PRINT DATA = LIBOCT34.TESTING_LAS_TOWN_DS;
		VAR Loan_Id Gender_short_name Remarks;
	RUN;
%END;

%MEND MACRO_CR1;

/*Call the Macro*/
%MACRO_CR1("CITY");
%MACRO_CR1("VILLAGE");
%MACRO_CR1("TOWN");

/***********************************************
Bar Chart
The groups were stacked one over above the other
***********************************************/
TITLE 'Number of family members by loan location';
PROC SGPLOT DATA = LIBOCT34.TESTING_LAS_PREDICTED_DS;
	vbar family_members /group = loan_location groupdisplay = cluster;
	Label family_members ='Number of family members';
RUN;

/***********************************************
Pie Chart
***********************************************/
TITLE 'Loan approval status by loan location';
PROC GCHART DATA = LIBOCT34.TESTING_LAS_PREDICTED_DS;
	pie3d I_LOAN_APPROVAL_STATUS/ GROUP=LOAN_LOCATION;
RUN;
QUIT;
