pragma solidity ^0.8.0;

contract PeerToPeerLending {
    struct Loan {
        address borrower;
        address lender;
        uint amount;
        uint interestRate;
        uint term;
        uint startDate;
        bool active;
        bool paid;
    }

    mapping (uint => Loan) public loans;
    uint public loanCounter;

    function createLoan(address _lender, uint _amount, uint _interestRate, uint _term) public returns (uint) {
        require(_lender != msg.sender, "Borrower and lender cannot be the same");
        require(_amount > 0, "Loan amount must be greater than zero");
        require(_term > 0, "Loan term must be greater than zero");

        Loan memory newLoan = Loan({
            borrower: msg.sender,
            lender: _lender,
            amount: _amount,
            interestRate: _interestRate,
            term: _term,
            startDate: block.timestamp,
            active: true,
            paid: false
        });

        loans[loanCounter] = newLoan;
        loanCounter++;

        return loanCounter - 1;
    }

    function repayLoan(uint _loanId) public payable {
        Loan storage loan = loans[_loanId];
        require(loan.active == true, "Loan is not active");
        require(msg.sender == loan.borrower, "Only borrower can repay loan");
        require(msg.value >= loan.amount, "Insufficient funds");

        loan.active = false;
        loan.paid = true;

        uint interest = (loan.amount * loan.interestRate * loan.term) / 100;
        uint totalAmount = loan.amount + interest;

        if (msg.value > totalAmount) {
            payable(msg.sender).transfer(msg.value - totalAmount);
        }

        payable(loan.lender).transfer(totalAmount);
    }

    function getLoan(uint _loanId) public view returns (address, address, uint, uint, uint, uint, bool, bool) {
        Loan storage loan = loans[_loanId];
        return (loan.borrower, loan.lender, loan.amount, loan.interestRate, loan.term, loan.startDate, loan.active, loan.paid);
    }
}
