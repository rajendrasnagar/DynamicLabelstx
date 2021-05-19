sfdx force:source:push -u ${CIRCLE_BRANCH}
sfdx force:apex:test:run --testlevel RunLocalTests --outputdir test-results --codecoverage --resultformat human --targetusername ${CIRCLE_BRANCH}