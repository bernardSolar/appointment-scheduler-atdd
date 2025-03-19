# Appointment Scheduler with ATDD

This project demonstrates using Acceptance Test-Driven Development (ATDD) with an AI assistant to build a simple appointment scheduling application.

## ATDD Approach

Following Dave Farley's Four-Layer Model:

1. **Test Cases** - Written in Gherkin format (see `features/*.feature` files)
2. **Domain-Specific Language (DSL)** - Implemented in the step definition files
3. **Protocol Drivers** - Capybara interface to our app
4. **System Under Test** - The actual appointment application

## Running Tests

```
bundle install
cucumber
```