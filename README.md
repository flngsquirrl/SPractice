# SPractice

How do you practice? Do you prefer workout or yoga?  
Well, good news are, you can combine or alternate.
And use your time wisely.

This is an application for you personal practice.

## Exercises

There are 3 types of exercises, that define how you practice:

- flow  
You decide when you finish and notify the app by pressing a button.  
Good, when you go at your own pace (Sun Salutations) or count (how about 50 squats, uh?).
    
- timer  
You set the time and practice with the count down.  
2 minutes of Cat-Cow or Jump Rope.
    
- tabata  
It is a famous HIIT technique, repeated intervals of activity and rest.  
Works good with all sorts of Planks.

## Programs

Programs are built out of exercises.

You probably have a favourite sequence or a few.  
But even if you don’t, try different combinations to find something that feels righ.

## Examples

Some examples are provided by default.  
You can modify or delete them at any time.  
And restore from Settings, if you change your mind later.

But try to experiment and create your own exercises and programs.

<p float="left">
<img width="300" alt="programs_dark" src="https://user-images.githubusercontent.com/95634326/190706089-f345b132-5822-4f0b-872f-9c3736d8e413.png#gh-dark-mode-only">
<img width="300" alt="exercises_dark" src="https://user-images.githubusercontent.com/95634326/190706146-c1b153fe-ac3e-4d91-b8da-0aa71834a4d7.png#gh-dark-mode-only">

<img width="300" alt="programs_light" src="https://user-images.githubusercontent.com/95634326/190711976-e55ff19e-f273-44ed-bcf4-ff7eb94726ec.png#gh-light-mode-only">
<img width="300" alt="exercises_light" src="https://user-images.githubusercontent.com/95634326/190706603-8a2f50ad-8266-4f3b-8044-da23361adbd0.png#gh-light-mode-only">
</p>

## Create an exercise

Give the exercise a name and, optionally, a description.  
You can stop here, if this is the information your want to use as a template.  
Or continue by settings its type, duration and intensity.

<p float="left">
<img width="300" alt="exercise_flow_dark" src="https://user-images.githubusercontent.com/95634326/190710950-e5a4fd23-a98e-46e9-ac37-0bcc062ab1a0.png#gh-dark-mode-only">
<img width="300" alt="exercise_timer_dark" src="https://user-images.githubusercontent.com/95634326/190707345-0f8b1ac8-851f-4347-908c-f76245b1a564.png#gh-dark-mode-only">
<img width="300" alt="exercise_tabata_dark" src="https://user-images.githubusercontent.com/95634326/190707358-3f8dd431-8900-4953-901a-0fddf52ab055.png#gh-dark-mode-only">

<img width="300" alt="exercise_flow_light" src="https://user-images.githubusercontent.com/95634326/190710816-b3bd25ea-9242-4a91-905a-627880ae86c6.png#gh-light-mode-only">
<img width="300" alt="exercise_timer_light" src="https://user-images.githubusercontent.com/95634326/190710838-6f64a6ad-9eee-4bfd-836e-3a58548535b8.png#gh-light-mode-only">
<img width="300" alt="exercise_tabata_light" src="https://user-images.githubusercontent.com/95634326/190710843-8638dce4-5827-4eb2-9409-c0fd3c9db961.png#gh-light-mode-only">
</p>

## Create a program

Start by giving the program a name and, if needed, a description.  
Then build a sequence selecting exercises from templates or creating new.  

Take a look at the program's duration.  
This is how long the practice will last.

<p float="left">
<img width="300" alt="program_create_dark" src="https://user-images.githubusercontent.com/95634326/190708503-b63fa80a-37ed-4bf6-a9c9-96bd3717d468.png#gh-dark-mode-only">
<img width="300" alt="program_select_dark" src="https://user-images.githubusercontent.com/95634326/190708528-ca0adbaf-17d1-4c8d-a405-2d6db4a1aa62.png#gh-dark-mode-only">
<img width="300" alt="program_select_2_dark" src="https://user-images.githubusercontent.com/95634326/190708566-6154b9b8-0207-4fd1-b721-14e00d68f21a.png#gh-dark-mode-only">
<img width="300" alt="program_personal_dark" src="https://user-images.githubusercontent.com/95634326/190708836-e52313a6-5ec5-4dd1-bcd2-13b245eb39cd.png#gh-dark-mode-only">

<img width="300" alt="program_create_light" src="https://user-images.githubusercontent.com/95634326/190712267-b161ddf3-4898-47fa-be13-7a093f6636aa.png#gh-light-mode-only">
<img width="300" alt="program_select_light" src="https://user-images.githubusercontent.com/95634326/190710210-33050e24-e8a1-4741-91ad-48e9087ca6b6.png#gh-light-mode-only">
<img width="300" alt="program_select_2_light" src="https://user-images.githubusercontent.com/95634326/190710213-4a0b1c2b-31ee-4fa7-8211-17f0817cc6ad.png#gh-light-mode-only">
<img width="300" alt="program_personal_light" src="https://user-images.githubusercontent.com/95634326/190710217-45443b36-b2fa-4802-961b-259a9d4ed9cd.png#gh-light-mode-only">
</p>

## Configure a practice

There are some helpful configs to make the practice better.  

First, you can add Rest intervals between the exercises.  
You can use them to prepare for the next exercise or take a sip of water.  

Second, you can pause after every exercise.  
It means, when an exercise is over, you should press "Run" to start the next.  
This gives you more control, but requires more interaction.  

Third, you can turn the sound notifications on and off.  
When on, the sound signal will let you know when the exercise or its task is about to finish.  

Now, ready? Then lets run the practice!

## Run a practice

Is Run option disabled?  
Then, please, make sure the following is true for the program's sequence:   
- type is set for all the exercises
- duration is set for all timers exercises

Is everyting fine? Ok, then lets practice)

## Practice

You can pause, restart an exercise or the whole practice at any moment.  
You can also turn the sound on and off, view exercise details or practice summary.  

Keep practicing)

## Settings

In Settings you can:
- set intervals for tabata exercises
- set name and duration for Rest intervals
- configure auto-finish for flow exercises
- manage modified examples

## Targets

iOS 16
iPhone, iPads

## Implementation details

Implemented with Swift and SwiftUI.  
Exercise and program templates are stored as JSON files in the app directory on the device.  
The application doesn't need access to any of the user's private information.
