clc;
clear all;
close all;
rng('shuffle');
Screen('Preference', 'SkipSyncTests', 2);
Screen('Preference','VisualDebugLevel', 1);
[window, window_size] = Screen('OpenWindow', 0, [255 255 255], [],32,2);

Screen(window,'TextFont','Arial');
Screen(window,'TextSize',300);
DrawFormattedText(window, ['Red'],'center', 'center', [255 0 0],[],[],[],2);
Screen('Flip',window);
WaitSecs(3);

Screen(window,'TextFont','Arial');
Screen(window,'TextSize',300);
DrawFormattedText(window, ['Orange'],'center', 'center', [255 165 0],[],[],[],2);
Screen('Flip',window);
WaitSecs(3);
%incorporate KbCheck to more accurately measure delay, boolean
%for whether answer is correct or not (press a key to indicate
%a certain color, code should tell if right or wrong)
Screen(window,'TextFont','Arial');
Screen(window,'TextSize',300);
DrawFormattedText(window, ['Yellow'],'center', 'center', [255 255 0],[],[],[],2);
Screen('Flip',window);
WaitSecs(3);

Screen(window,'TextFont','Arial');
Screen(window,'TextSize',300);
DrawFormattedText(window, ['Green'],'center', 'center', [0 255 0],[],[],[],2);
Screen('Flip',window);
WaitSecs(3);

Screen(window,'TextFont','Arial');
Screen(window,'TextSize',300);
DrawFormattedText(window, ['Blue'],'center', 'center', [0 0 255],[],[],[],2);
Screen('Flip',window);
WaitSecs(3);

Screen(window,'TextFont','Arial');
Screen(window,'TextSize',300);
DrawFormattedText(window, ['Purple'],'center', 'center', [75 0 130],[],[],[],2);
Screen('Flip',window);
WaitSecs(3);

for i = 1:10
    
randomColors = {'Red','Orange', 'Yellow', 'Green', 'Blue', 'Purple'};
randomColors2 = {[255 0 0], [255 165 0], [255 255 0], [0 255 0], [0 0 255], [75 0 130]};
pickone = randi([1,6]);
pickanother = randi([1,6]);
while pickanother == pickone
    pickanother = randi([1,6]);
end

Screen(window,'TextFont','Arial');
Screen(window,'TextSize',300);
DrawFormattedText(window, [randomColors{pickone}],'center', 'center', randomColors2{pickanother},[],[],[],2);
Screen('Flip',window);
WaitSecs(3);
end

Screen('CloseAll');