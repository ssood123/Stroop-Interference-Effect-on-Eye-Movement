Wikipedia states, “the Stroop effect is a demonstration of interference in the reaction time of a task. When the name of a color (e.g., "blue", "green", or "red") is printed in a color which is not denoted by the name (i.e., the word "red" printed in blue ink instead of red ink), naming the color of the word takes longer and is more prone to errors than when the color of the ink matches the name of the color.” When the name of a color is printed in a color which is denoted by the name, we refer to it as a congruent stimuli. Otherwise, when the name of a color is printed in a color which is NOT denoted by the name, we refer to it as an incongruent stimuli.

In our experiment, we aim to see record eye movements (saccades) when showing a test subject congruent and incongruent stimuli. We predict that saccades will be greater and more erratic when the test subject is shown incongruent stimuli as opposed to congruent stimuli because the brain has more to process. We will test our hypothesis by showing a random mix of 150 congruent stimuli and 150 incongruent and compiling the graphs of the test subject’s eye movements for each stimuli in the order the stimuli are shown 

Our first program, stroopeffect.m, is the actual experiment. Although the real program shows 300 stimuli, we will assume four as an example. Here is an example of how the program functions:

-The program shows a central dot (called a fixation point) for 1 second to stabilize eye movements.
-The program shows a centered ‘Red’ where each letter has a blue color (an incongruent stimuli).
-The program waits until the user presses any key. The user is supposed to press the key corresponding to the COLOR of the word (‘b’ for blue, in this case), but the program accepts any key press.
-The program shows a fixation point for 1 second.
-The program shows a centered ‘Green’ where each letter has a green color (a congruent stimuli).
-The program waits until the user presses any key.
-The program shows a fixation point for 1 second.
-The program shows a centered ‘Orange’ where each letter has an orange color (a congruent stimuli).
-The program waits until the user presses any key.
-The program shows a fixation point for 1 second.
-The program shows a centered ‘Purple’ where each letter has a yellow color (an incongruent stimuli).
-The program shows a fixation point for 1 second.


Of course, data is recorded throughout the program. First, the user’s eye movements are recorded, and this data will be used to create graphs later on. Second, data for each stimuli is recorded in a .dat file. Each row corresponds to the stimuli shown in chronological order. This is called the chronological .dat file. The first column corresponds to the word stimuli itself, the second column corresponds to the color of the word stimuli, the third column corresponds to the reaction time (defined as the time it takes for the user to press a key right after a stimuli is shown) in seconds, and the fourth column corresponds to whether the user pressed the right key or not (0 for right, 1 for wrong).
Here is what the .dat file might look like (continuing with the previous example):  

Row 1:  Red  Blue  1.27  0
Row 2:  Green  Green  .75  1
Row 3:  Orange  Orange .87  1
Row 4:  Purple  Yellow  1.80  1

We also create two more .dat files. Both .dat files still have the stimuli in chronological order, but 1 only has the congruent stimuli (called the chronological .dat file) and 1 only has the incongruent stimuli (called the incongruent .dat file). Here is what the congruent .dat file looks like:

Row 1:  Green  Green  .75  1
Row 2:  Orange  Orange  .87  1

Here is what the incongruent .dat file looks like:

Row 1:  Red  Blue  1.27  0
Row 4:  Purple  Yellow  1.80  1

After stroopeffect.m is finished, we use driver.m next. In general, this program is tasked with prompting the user to enter the figure number(s) to be generated, generating said figures, then saving them to a specific directory. The figure numbers aren’t what one would expect, however. Since 4 stimuli are shown in the example experiment, the first 2 figures correspond to the congruent stimuli and the last 2 correspond to the incongruent stimuli. Here is a modified chronological .dat file showing the figure numbers for each stimuli:
Row 1:  Red  Blue  1.27  0  (Figure 3)
Row 2:  Green  Green  .75  1  (Figure 1)
Row 3:  Orange  Orange .87  1  (Figure 2)
Row 4:  Purple  Yellow  1.80  1  (Figure 4)

This means figure 3 graphs the eye movement data for the Red Blue stimuli and so on.

Here is how each figure is generated. As stated before, stroopeffect.m records eye movements during the experiment. It does this in an .asc file. Since stroopeffect.m puts specific markers in the .asc file, driver.m knows how to graph the right data for each stimuli. Using the Red Blue stimuli as an example, driver.m graphs the eye movement data for the time period between when the Red Blue stimuli is shown and when the user presses a key. Each figure has the word and color as the tile and the plots. In addition, the figures have a gray word in the background that looks exactly how the stimulus looked in the experiment save for the color. Essentially, we are trying to plot eye movements over the exact stimuli shown during stroopeffect.m since this will help us determine where the user's eyes are in relation to the stimuli. Using the Red Blue stimuli as an example again, the title for the figure corresponding to this stimuli would be ‘RedBlue’ and there would be a gray ‘Red’ in the background of the plot with the eye movement graphs superimposed. 

After we use this program to generate all the figures and they are saved in our directory, we use arrange.m. In general, this program is responsible for determining the correct chronological order of the figures. The figures in are directory would be stored as figure 1, figure 2, figure 3, and figure 4, but this is not the correct chronological order. Arrange.m determines the correct order to be figure 3, figure 1, figure 2, and figure 4 using the three .dat files made in stroopeffect.m. After creating a vector with the correct chronological order of the figures, arrange.m creates a python list with the same data as the vector that can be copied and pasted into a python script.

makepdf.py, the python script, is in the same directory as the figures that are saved. It is responsible for using the list generated by arrange.m to put the figures in a word document in the correct chronological order. 
