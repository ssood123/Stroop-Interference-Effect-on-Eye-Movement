%SETUP
try
    clc;
    clear;
    close all;
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
    nameoffile1 = strcat(nameoffile,'c.dat');
    nameoffile2 = strcat(nameoffile,'i.dat');
    fid1 = fopen(nameoffile1,'w');
    fid2 = fopen(nameoffile2,'w');
    commandwindow;
    dummymode = 0;
    PsychDefaultSetup(2);
    Screen('Preference', 'SkipSyncTests', 0);
    screens = Screen('Screens');
    screenNumber = max(screens);
    rand('seed', sum(100 * clock));
    prompt = {'Enter tracker EDF file name (1 to 8 letters or numbers)'};
    dlg_title = 'Create EDF file';
    num_lines= 1;
    def     = {'DEMO'};
    answer  = inputdlg(prompt,dlg_title,num_lines,def);
    edfFile = answer{1};
    fprintf('EDFFile: %s\n', edfFile );
    
    white = WhiteIndex(screenNumber);
    black = BlackIndex(screenNumber);
    
    rng('default');
    rng('shuffle');
    
    
    % Screen('Preference', 'SkipSyncTests', 2);
    Screen('Preference','VisualDebugLevel', 1);
    [window, window_size] = Screen('OpenWindow', 0, [255 255 255], [],32,2);
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    
    start = GetSecs;
    
    %VARIABLES
    randomColors = {'Red','Orange', 'Yellow', 'Green', 'Blue', 'Purple'};
    randomColors2 = {[255 0 0], [255 165 0], [255 255 0], [0 255 0], [0 0 255], [75 0 130]};
    keyRed = KbName('r');
    keyOrange = KbName('o');
    keyYellow = KbName('y');
    keyGreen = KbName('g');
    keyBlue = KbName('b');
    keyPurple = KbName('p');
    shuffler = repmat([1 2],6);
    shuffler = shuffler(randperm(length(shuffler)));
    congruent_index = 1;
    incongruent_index = 1;
    
    
    el=EyelinkInitDefaults(window);
    if ~EyelinkInit(dummymode, 1)
        fprintf('Eyelink Init aborted.\n');
        Eyelink('Shutdown');
        sca;
        return;
    end
    res = Eyelink('Openfile', edfFile);
    if res~=0
        fprintf('Cannot create EDF file ''%s'' ', 'ERROR');
        return;
    end
    
    
    if Eyelink('IsConnected')~=1 && dummymode
        
        cleanup;
        return;
    end
    
    
    Eyelink('command', 'add_file_preamble_text ''Recorded by EyelinkToolbox demo-experiment''');
    Eyelink('command', 'file_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT');
    Eyelink('command', 'file_sample_data  = LEFT,RIGHT,GAZE,HREF,AREA,GAZERES,STATUS,INPUT,HTARGET');
    Eyelink('command', 'link_event_filter = LEFT,RIGHT,FIXATION,SACCADE,BLINK,MESSAGE,BUTTON,INPUT,FIXUPDATE');
    Eyelink('command', 'link_sample_data  = LEFT,RIGHT,GAZE,GAZERES,AREA,STATUS,INPUT,HTARGET');
    
    Eyelink('command', 'select_eye_after_validation = NO');
    EyelinkUpdateDefaults(el);
    HideCursor;
    % Calibrate the eye tracker
    EyelinkDoTrackerSetup(el);
    n = 'Test begin';
    DrawFormattedText(window, 'Press a key to begin the test'...
        , 'center', 'center', white);
    Screen('Flip', window);
    KbStrokeWait;
    % Before recording, we place reference graphics on the host display
    % Must be in offline mode to transfer image to Host PC
    Eyelink('Command', 'set_idle_mode');
    % clear tracker display and draw box at center
    Eyelink('Command', 'clear_screen %d', 0);
    Eyelink('message', 'SYNCTIME')
    EyelinkDoDriftCorrection(el);
    WaitSecs(0.1);
    Eyelink('StartRecording');
    WaitSecs(0.1);
    
    %DISPLAYS INITIAL FIXATION POINT
    Screen(window,'TextFont','Arial');
    Screen(window,'TextSize',200);
    Screen('FillOval', window , [0 0 0], [1280/2-40,720/2-40,1280/2+40,720/2+40]);
    Screen('Flip',window);
    WaitSecs(1);
    
    %DISPLAYS A CONGRUENT OR INCONGRUENT DISPLAY
    for i = shuffler
        if i == 1
            pickone = randi([1,6]);
            word = randomColors{pickone};
            color = randomColors2{pickone};
            DrawFormattedText(window, word,'center', 'center', color,[],[],[],2);
            color = randomColors{pickone};
            Screen('Flip',window);
            Eyelink('message',strcat('C-Test',num2str(congruent_index)));
            tic
            [~, keyCode, ~] = KbWait;
            time = toc;
            Eyelink('message',strcat('EC-Test',num2str(congruent_index)));
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
            congruent_index = congruent_index + 1;
            fprintf(fid1,'%s %s %f %d\n',word,color,time,correctanswer);
            Screen('FillOval', window , [0 0 0], [1280/2-40,720/2-40,1280/2+40,720/2+40]);
            Screen('Flip',window);
            WaitSecs(1);
        elseif i == 2
            pickone = randi([1,6]);
            pickanother = randi([1,6]);
            while pickanother == pickone
                pickanother = randi([1,6]);
            end
            word = randomColors{pickone};
            color = randomColors2{pickanother};
            DrawFormattedText(window, word,'center', 'center', color,[],[],[],2);
            color = randomColors{pickanother};
            Screen('Flip',window);
            Eyelink('message',strcat('I-Test',num2str(incongruent_index)));
            tic
            [~, keyCode, ~] = KbWait;
            time = toc;
            Eyelink('message',strcat('EI-Test',num2str(incongruent_index)));
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
            incongruent_index = incongruent_index + 1;
            fprintf(fid2,'%s %s %f %d\n',word,color,time,correctanswer);
            Screen('FillOval', window , [0 0 0], [1280/2-40,720/2-40,1280/2+40,720/2+40]);
            Screen('Flip',window);
            WaitSecs(1);
        end
    end
    
    
    
    
    error = Eyelink('checkrecording');
    [keyIsDown, secs, keyCode] = KbCheck;
    if Eyelink('isconnected') == el.dummyconnected
        [x,y,button] = GetMouse(window);
        evt.type=el.ENDSACC;
        evt.genx=x;
        evt.geny=y;
        evtype=el.ENDSACC;
    else
        evtype=Eyelink('getnextdatatype');
    end
    if Eyelink('newfloatsampleavailable') > 0
        evt = Eyelink ('newestfloatsample');
        
        x = evt.gx(2);
        y = evt.gy(2);
        x2 = evt.gx(1);
        y2 = evt.gy(1);
        timeSinceLast = GetSecs - start;
        start = GetSecs;
    end
    Eyelink('StopRecording');
    Eyelink('message', 'TRIALOK');
    Eyelink('ReceiveFile');
    Eyelink('CloseFile');
catch error
    fprintf('%s\n', error.message);
    
    sca;
    
end

Screen('CloseAll');
fclose(fid1);
fclose(fid2);
