*** Variables ***
${SYSTEM_USERS_HEADER}         xpath://h5[text()='System Users']
${ADMIN_USERNAME_FIELD}        xpath://div[label[text()='Username']]//following-sibling::div/input
${EMPLOYEE_NAME_FIELD}         xpath://div[label[text()='Employee Name']]//following-sibling::div//input
${USER_ROLE_FIELD}             xpath://div[label[text()='User Role']]//following-sibling::div//div[@class='oxd-select-text-input']
${STATUS_FIELD}                xpath://div[label[text()='Status']]//following-sibling::div//div[@class='oxd-select-text-input']
${RESET_BUTTON}                xpath://button[normalize-space()='Reset']
${SEARCH_BUTTON}               xpath://button[normalize-space()='Search']
${ADD_BUTTON}                  xpath://button[normalize-space()='Add']
${RECORD_TABLE}                css:.orangehrm-container
${EMPLOYEE_NAMES}              css:.oxd-table-cell:nth-child(2) div
