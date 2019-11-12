dnf_service = Service.create(name:'地下城与勇士', de_name:'DNF', rate:100)
AccountTypeService.create(account_type_id: qq_bank_account_type.id, service_id:dnf_service.id)