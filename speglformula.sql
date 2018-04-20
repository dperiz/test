/********************************************************************************
Program		: speglformula.sql
Description	: update budget in gl allocation formula to current budget
Author		: FRT (KYN) 
Remark		: use APPS accounts to run the script

*********************************************************************************/

UPDATE gl_alloc_formula_lines gafl
   SET gafl.budget_version_id = (SELECT gbve.budget_version_id
                                 FROM gl_budget_versions gbve
                                 WHERE gbve.budget_name='&BUDGET_NAME')
 WHERE gafl.allocation_formula_id IN (
          SELECT gafo.allocation_formula_id
          FROM gl_alloc_formulas gafo
          WHERE gafo.je_category_name = 'Budget'
          AND gafo.validation_status = 'V'
          )
AND    gafl.budget_version_id IS NOT NULL


--REM EXECUTE COMMIT; IF OK