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
times = {'2','1'};
correctanswerslist1 = [];
correctanswerslist2 = [];
timeslist1 = [];
timeslist2 = [];
colorslist = {};
wordslist = {};

%DISPLAYS EACH WORD AND ITS OWN COLOR
for i = 1:2
    Screen(window,'TextFont','Arial');
    Screen(window,'TextSize',300);
    word = randomColors{i};
    color = randomColors2{i};
    wordslist{end+1} = word;
    colorslist{end+1} = randomColors{i};
    DrawFormattedText(window, word,'center', 'center', color,[],[],[],2);
    Screen('Flip',window);
    WaitSecs(.2);
    [secs, keyCode, deltaSecs] = KbWait;
    answer = 0;
     if keyCode(21) == 1
        answer = [255 0 0];
    elseif keyCode(18) == 1
        answer = [255 165 0];
    elseif keyCode(28) == 1
        answer = [255 255 0];
    elseif keyCode(10) == 1
        answer = [0 255 0];
    elseif keyCode(5) == 1
        answer = [0 0 255];
    elseif keyCode(19) == 1
        answer = [75 0 130];
    end

    if isequal(answer,color)
        correctanswerslist1(end+1) = 1;
    else
        correctanswerslist1(end+1) = 0;
    end
    timeslist1(end+1) = deltaSecs;
    for j = 1:1
        %DrawFormattedText(window,times{j},window_size(3)/2, window_size(4)/2+50, [0 0 0],[],[],[],2);
        Screen('FillOval', window , [0 0 0], [1280/2-40,720/2-40,1280/2+40,720/2+40]);
        Screen('Flip',window);
        WaitSecs(1);
    end
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
    wordslist{end+1} = word;
    colorslist{end+1} = randomColors{pickanother};
    DrawFormattedText(window, word,'center', 'center', color,[],[],[],2);
    Screen('Flip',window);
    WaitSecs(.2);
    [secs, keyCode, deltaSecs] = KbWait;
    if keyCode(21) == 1
        answer = [255 0 0];
    elseif keyCode(18) == 1
        answer = [255 165 0];
    elseif keyCode(28) == 1
        answer = [255 255 0];
    elseif keyCode(10) == 1
        answer = [0 255 0];
    elseif keyCode(5) == 1
        answer = [0 0 255];
    elseif keyCode(19) == 1
        answer = [75 0 130];
    end

    if isequal(answer,color)
        correctanswerslist2(end+1) = 1;
    else
        correctanswerslist2(end+1) = 0;
    end
    timeslist2(end+1) = deltaSecs;
    for j = 1:1
        %DrawFormattedText(window,times{j},'center', 'center'-50, [0 0 0],[],[],[],2);
        %DrawFormattedText(window,times{j},window_size(3)/2, window_size(4)/2+50, [0 0 0],[],[],[],2);
        Screen('FillOval', window , [0 0 0], [1280/2-40,720/2-40,1280/2+40,720/2+40]);
        Screen('Flip',window);
        WaitSecs(1);
    end
end

Screen('CloseAll');
correctanswerslist = [correctanswerslist1 correctanswerslist2];
timeslist = [timeslist1 timeslist2];
nameoffile = input('Enter your info in this format: lastnamefirstname: ','s');
nameoffile = strtrim(nameoffile);
nameoffile = strcat(nameoffile,'.dat');
fid = fopen(nameoffile,'w');
for i = 1:length(colorslist)
    fprintf(fid,'%s %s %f %d\n',wordslist{i},colorslist{i},timeslist(i),correctanswerslist(i));
end
fclose(fid);

