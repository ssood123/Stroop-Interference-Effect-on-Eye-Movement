%SETUP
clc;
clear all;
close all;
rng('shuffle');
Screen('Preference', 'SkipSyncTests', 2);
Screen('Preference','VisualDebugLevel', 1);
[window, window_size] = Screen('OpenWindow', 0, [255 255 255], [],32,2);

%VARIABLES
waittime = .5;
randomColors = {'Red','Orange', 'Yellow', 'Green', 'Blue', 'Purple'};
randomColors2 = {[255 0 0], [255 165 0], [255 255 0], [0 255 0], [0 0 255], [75 0 130]};

%DISPLAYS EACH WORD AND ITS OWN COLOR
for i = 1:6
    Screen(window,'TextFont','Arial');
    Screen(window,'TextSize',300);
    DrawFormattedText(window, randomColors{i},'center', 'center', randomColors2{i},[],[],[],2);
    Screen('Flip',window);
    KbWait;
    WaitSecs(waittime);
end

%DISPLAYS A RANDOM WORD WITH A RANDOM COLOR
for i = 1:10
    pickone = randi([1,6]);
    pickanother = randi([1,6]);
    while pickanother == pickone
        pickanother = randi([1,6]);
    end
    Screen(window,'TextFont','Arial');
    Screen(window,'TextSize',300);
    DrawFormattedText(window, randomColors{pickone},'center', 'center', randomColors2{pickanother},[],[],[],2);
    Screen('Flip',window);
    KbWait;
    WaitSecs(waittime);
end
 
Screen('CloseAll');
