/****** Script for SelectTopNRows command from SSMS  ******/



select * from sp_main where sppono='TME20230517001'


use intra;
  DBCC SHOWCONTIG with tableresults,all_indexes
  
   

  /*
  DBCC INDEXDEFRAG('intra','cost_sign_remark','PK_cost_sign_remark')
  DBCC INDEXDEFRAG('intra','cost_estimateItem','PK_cost_estimateItem')
  DBCC INDEXDEFRAG('intra','cost_approvalPrice','PK_cost_approvalPrice')
  DBCC INDEXDEFRAG('intra','cost_estimateMain','PK_cost_estimateMain')
  DBCC INDEXDEFRAG('intra','cost_estimateMain','IDX_COST_ESTIMATE_MAIN')
  DBCC INDEXDEFRAG('intra','crm_PartNumberCategory','PK_crm_PartNumberChannel')
  */

  DBCC INDEXDEFRAG('intra','crm_PartNumberCategory','IDX_Leader')
  /*
  IX_sy_person_1
idx_01
IDX_Leader
  */
