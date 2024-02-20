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

Since LinkedIn's job search isn't the primary goal of the platform, we can be experimental with the
potentially noisy UI choice. 50-50 helps us maximize the power of the test amongst those open to work.

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
- Time_to_fill_position
  The ratio of time to fill job posting after applying the badge to time to fill before applying the badge
  avg(n_days_to_fill_position_after_badge)/avg(n_days_to_fill_position_before_badge)
  Rationale: Is the time taken to fill a vacancy affected by an expert recruiter's LinkedIn profile.

### Experiment 2

Changes: [Add details on others' career graph after LinkedIn course completion/certification]
Objective: Checking if people sign up for a course, after knowing that 'n' other data engineers have this on 
their LinkedIn profile.

Hypothesis: Is the course sign up higher once the data on who else has this on their LinkedIn is accessed?

Test cell allocation (Mild)

- Control (no feature) - [75 % LinkedIn users]
- Treatment [Career graph data available] - [25 % LinkedIn users]
Since this is a subtle UI change, we could benefit from the smaller treatment group. The larger control group should provide
the necessary statistical power for this A/Btest. 

Leading Metrics:

- Click rate on button with 'other's who signed up for this course' data
   Click rate = (#clicks / #impressions)*100
- Open to work tag on their LinkedIn profile
   The open_to_work_badge is modelled as a type 2 SCD, that tracks this badge over time with start_date, end_date
   The leading metric would be the beginning of an open_to_work streak.
    
Lagging Metrics:

- Course sign up rate
   course_sign_up_rate = (# sign ups/ #sessions)*100
   The number of people who sign up for the course in comparison to the visitors to the page, is expected to vary based on who else took this course.
   
- Course completion rate
   course_completion_rate = (# students who completed the course/ # students who enrolled in the course)*100
   The effectiveness of making others who took this course available, could be indicator of how important other aspirants find this in their journey.

### Experiment 3 (UI design)

Changes: Intersperse native LinkedIn content(like LinkedIn News, LinkedIn Courses, Daily Rundown) with user generated content in 
the feed.

Hypothesis: Changing layout doesn't affect engagement with native LinkedIn content.

Test cell allocation: (Radical)
- Control (standard layout, no new feature) - 30% LinkedIn users
- Treatment group [combined newsfeed with native and user generated content] - 70% LinkedIn users
Exposing more users to the new UI design, will increase the chances of finding a positive effect and improve user experience.
Considering LinkedIn's large user base of 850mill, we can expect a large effect size due to the significant difference between 
two groups.

- Leading Metrics:
- #platform exits after noticing user generated content to other platforms like Youtube, Spotify other websites.
      Bounce_rate = (#bounces/#sessions)*100  (leaving without any interaction with LinkedIn content)

- #active interactions with newsfeed items (like, comment, repost) 
      Exit_rate = (#exits/ #views or sessions)*100  (leaving after interacting with LinkedIn content)
      
Both these metrics can help one understand the page layout or actions that cause users to leave or stay.

Lagging Metrics:

- Click-rate on native LinkedIn content
  Click_rate = (#clicks_on_native_LinedIn_content/#impressions)*100
- Time spent on native LinkedIn content
  Time_elapsed = start_time("native_LinkedIn_activity") -end_time("native_LinkedIn_activity")

We'd like to favour a page layout that causes a uptick in click_rate and time_elapsed metrics.