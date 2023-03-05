# peer-to-peer-lending protocol

Allow users to lend assets based on the credit score retrieved from Spectral Finance. There will be an interest and lending period, users can repay the loan at any time. Deployed on Base, using Spectral finance oracle

## Design

1. Borrower requests a loan from the Lender
2. The smart contract calls the Spectral Finance oracle to get the credit score of the borrower
3. The smart contract checks if the credit score is above the minimum required
4. Lender creates a loan and transfers the funds to the smart contract
5. The smart contract transfers the funds to the borrower
6. The borrower can repay the loan at any time

### This is what we got

```mermaid
    
```

```mermaid
sequenceDiagram
    autonumber

    #participant Web App
    #participant Smart contract
    #participant Borrower
    #participant Lender
    #participant Spectral Finance oracle

    Worker ->> Web App: Request a loan
    Web App ->> P2P Lending Smart contract
    Smart Contract -->> Spectral Finance oracle: getCreditScore()
    
    Spectral Finance oracle -->> Smart Contract: creditScore

    Smart Contract -->> lender -->> creates loan on Base

    lender -->> Smart Contract: loanId
```
