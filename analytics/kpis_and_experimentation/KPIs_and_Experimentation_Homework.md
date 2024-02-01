# Analytics Track KPIs and Experimentation Homework

## User Story

Product: LinkedIn

My interaction as a user has mostly been as a consumer. I joined LinkedIn in June 3rd 2016, so I've been on the platform for the past 7 years. 
My initial goal was getting to know the grad community since I was moving to a new country. I've tended to use the platform extensively while looking for jobs.

Over time, I've had experience with LinkedIn premium features, random messages from recruiters and sales/marketing professionals and LinkedIn learning platform.
My frequency of interaction with all these features have been intermittent.

## Experiments

In this section, you'll specify tests and hypotheses for new features on your product of choice.

### Experiment 1

Changes: Add Label for recruiter: 'Expert recruiter' something like AirBnB's 'Super Host' 

Hypothesis: The label attracts more job-candidates to Expert recruiter's LinkedIn profile/DMs.

Test cell allocation:

- Control (no feature) - [50 %  LinkedIn users who are open to work ]
- Expert Recruiter label on - [50% LinkedIn users who are open to work]


Leading Metrics:
- Recruiter Response Rate
 The percentage of candidates who closed the loop in conversation with the recruiter over this time window of badge addition
  to number of job applicants
  Definition: #(candidates who received a response from the recruiter within the time window) / Total number of candidates who applied for the job x 100
  Rationale: Capture the correlation between candidate's application to DMs with recruiter.
- Quality of candidate pipeline
  The percentage of converted job applicants over applicants to the job posting.
  Definition: sum(boolean flag confirming conversion from application to interview) / sum(number of candidates who applied for the job) x 100
  Rationale: Capture the correlation between quality candidates being attracted to expert recruiter's profile.



Lagging Metrics:
- Engagement Rate
  The ratio of visits to job posting after applying the badge to clicks before applying the badge
  n_visits_after_badge/n_visits_before_badge
  Rationale:Expert recruiter badge may attract more clicks 
- Time_to_fill
  The ratio of time to fill job posting after applying the badge to time to fill before applying the badge
  avg(n_days_to_fill_position_after_badge)/avg(n_days_to_fill_position_before_badge)
  Rationale: Is the time taken to fill a vacancy affected by an expert recruiter's LinkedIn profile.

### Experiment 2

Changes: [Add details on others' career graph after LinkedIn course completion/certification]
Objective: Checking if people sign up for a course, after knowing that 20 other data engineers have this on 
their LinkedIn profile.

Hypothesis: Is the course sign up higher once the data on who else has this on their LinkedIn is accessed?

Test cell allocation:

- Control (no feature) - [50 % LinkedIn users]
- [Career graph data available] - [50 % LinkedIn users]

Leading Metrics:

- Click rate on button with 'other's who signed up for this course' data 
- Open to work tag on their LinkedIn profile

Lagging Metrics:

- Course sign up rate
- Course completion rate

### Experiment 3 (UI design)

Changes: Intersperse native LinkedIn content(like LinkedIn News, LinkedIn Courses, Daily Rundown) with user generated content in 
the feed.

Hypothesis: [Enter your hypothesis about what the result of making the new changes will be.]
Changing layout doesn't affect engagement with native LinkedIn content.

Test cell allocation:

- Control (no feature) - 50% LinkedIn users
- [combined newsfeed with native and user generated content] - 50% LinkedIn users

Leading Metrics:
- #platform exits after interacting with user generated content (to Youtube, Spotify other websites)
- #active interactions with newsfeed items (like, comment, repost) 

Lagging Metrics:

- Click-rate on native LinkedIn content
- Time spent on native LinkedIn content