%SETUP
clc;
clear all;
close all;
rng('shuffle');
Screen('Preference', 'SkipSyncTests', 2);
Screen('Preference','VisualDebugLevel', 1);
[window, window_size] = Screen('OpenWindow', 0, [255 255 255], [],32,2);

%FILE MAKING
last = input('Enter your last name: ','s');
last = strtrim(last);
first = input('Enter your first name: ','s');
first = strtrim(first);
t = datetime;
DateString = datestr(t);
[DateString, ~] = strtok(DateString);
nameoffile = strcat(last,first);
nameoffile = strcat(nameoffile,DateString);
nameoffile = strcat(nameoffile,'.dat');
fid = fopen(nameoffile,'w');

%VARIABLES
randomColors = {'Red','Orange', 'Yellow', 'Green', 'Blue', 'Purple'};
randomColors2 = {[255 0 0], [255 165 0], [255 255 0], [0 255 0], [0 0 255], [75 0 130]};
keyRed = KbName('r');
keyOrange = KbName('o');
keyYellow = KbName('y');
keyGreen = KbName('g');
keyBlue = KbName('b');
keyPurple = KbName('p');

%DISPLAYS EACH WORD AND ITS OWN COLOR
for i = 1:2
    Screen(window,'TextFont','Arial');
    Screen(window,'TextSize',300);
    word = randomColors{i};
    color = randomColors2{i};
    DrawFormattedText(window, word,'center', 'center', color,[],[],[],2);
    color = randomColors{i};
    Screen('Flip',window);
    WaitSecs(.2);
    tic
    [~, keyCode, ~] = KbWait;
    toc
    time = toc;
    answer = 0;
    if keyCode(keyRed) == 1
        answer = 'Red';
    elseif keyCode(keyOrange) == 1
        answer = 'Orange';
    elseif keyCode(keyYellow) == 1
        answer = 'Yellow';
    elseif keyCode(keyGreen) == 1
        answer = 'Green';
    elseif keyCode(keyBlue) == 1
        answer = 'Blue';
    elseif keyCode(keyPurple) == 1
        answer = 'Purple';
    end
    if isequal(answer,color)
        correctanswer = 1;
    else
        correctanswer = 0;
    end
    fprintf(fid,'%s %s %f %d\n',word,color,time,correctanswer);
    Screen('FillOval', window , [0 0 0], [1280/2-40,720/2-40,1280/2+40,720/2+40]);
    Screen('Flip',window);
    WaitSecs(1);
end
    

%DISPLAYS A RANDOM WORD WITH A RANDOM COLOR
for i = 1:2
    pickone = randi([1,6]);
    pickanother = randi([1,6]);
    while pickanother == pickone
        pickanother = randi([1,6]);
    end
    Screen(window,'TextFont','Arial');
    Screen(window,'TextSize',300);
    word = randomColors{pickone};
    color = randomColors2{pickanother};
    DrawFormattedText(window, word,'center', 'center', color,[],[],[],2);
    color = randomColors{pickanother};
    Screen('Flip',window);
    WaitSecs(.2);
    tic
    [~, keyCode, ~] = KbWait;
    toc
    time = toc;
    if keyCode(keyRed) == 1
        answer = 'Red';
    elseif keyCode(keyOrange) == 1
        answer = 'Orange';
    elseif keyCode(keyYellow) == 1
        answer = 'Yellow';
    elseif keyCode(keyGreen) == 1
        answer = 'Green';
    elseif keyCode(keyBlue) == 1
        answer = 'Blue';
    elseif keyCode(keyPurple) == 1
        answer = 'Purple';
    end
    if isequal(answer,color)
        correctanswer = 1;
    else
        correctanswer = 0;
    end
    fprintf(fid,'%s %s %f %d\n',word,color,time,correctanswer);
    Screen('FillOval', window , [0 0 0], [1280/2-40,720/2-40,1280/2+40,720/2+40]);
    Screen('Flip',window);
    WaitSecs(1);
 end

Screen('CloseAll');
fclose(fid);
