describe('E2E Form spec', () => {
  it('site loading', () => {
    cy.visit('http://localhost:5173/pages/')
  })

  it('has all visible fields', () => {
    cy.visit('http://localhost:5173/pages/')
    cy.get('[id=Firstname]').should('be.visible')
    cy.get('[id=Lastname]').should('be.visible')
    cy.get('[id=Email]').should('be.visible')
    cy.get('[id=CompanyName]').should('be.visible')
    cy.get('[id=CompanyID]').should('be.visible')
    cy.get('[id=Reason]').should('be.visible')
    cy.get('[id=send]').should('be.visible') 
    
  })
})