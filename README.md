# herd

Find Your Herd is a platform for college students to find other students to walk with from place to place during times when they feel uncomfortable or unsafe to walk alone. By helping students find friends to schedule walks with, we hope to help students feel safer while walking to and from places in the Hyde Park region, especially after sundown.

# GLOBAL CONTENT
- User states: Idle, walk requested, walk decided, in walk

# HOME PAGE
- Login info 
- UI for username + password + wrong pass etc 
- Maybe log in with uchicago 
- Authentication 

# CREATE ACCOUNT PAGE (if we can't figure log in with uchicago id) 
- Form on front end that fills db in backend
- Name, username, password, picture

# FIRST PAGE
- Front end
  - map
  - when do u want to start your walk
  - radius of walk start via circle
  - end location intersection + landmarks

- Back end
  - store time, start n end location, radius, approx walk time

# MATCH PAGE
- Front end
  - Walks starting from your location during ur time period amongst friends
- Back end 
  - tracking start location + time periods + updating state 
  - Update walks based on matches (show if atleast one is ur friend) 
 
 # CHAT
 - Basic chat functionality

# PROFILE PAGE
- Basic profile page

# ADD FRIENDS
- Basic add friends page 


User:
- name
- username
- picture
- current state
- pronouns

User Walk:
- walk_id
- username
- Start intersection/landmark
- End intersection/landmark
- current state 
- duration (when state == in walk)

Walk:
- walk_id
- [Users] 
- [Start intersection/landmark]
- [End intersection/landmark]
- Start time
