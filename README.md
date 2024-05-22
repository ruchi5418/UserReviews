# Tendable Coding Assessment

## Usage

```sh
bundle
ruby questionnaire.rb
```
## Approach 
- pstore library is used to store the answers given by user for each run and which then used to calculate the average rating.
- do_promt method iterates on each question given in the QUESTIONS object and collects the user response. While doing so answer is validated against [Yes, No, Y, N] options and then stored in answers objects which contains all the answers for that particular run.
- In next step, these answers are stored in pstore object that is store. Each :run is used ad key while storing the data for each run in store. Each run contains the array of the answer for that particular run.
- In current_run_rating, average rating of that run is calculated based on the number of "Yes" answers provided by the user.
- In calculate_average_rating, calculates the average rating across all runs stored in the PStore. It iterates over each run, counts the total "Yes" answers and the total number of questions, and then calculates the average rating.
- do_report, takes the current run rating and the average rating as inputs and prints them to the console.


## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise

