%Concatenate data - HTM Project
%AVP 2016


%Clean workspace
clap

%Concatenate data
for animal = 1:5
    for day = 1:8
        for layer = 1:4;
            tempact{layer} = proj_meta(animal).rd(layer,day).act;
        end
        act{animal,day} = vertcat(tempact{1:4}); %Cell activity across layers
        airPuff{animal,day} = proj_meta(animal).rd(layer,day).AirPuff; %AirPuff signals
        lick{animal,day} = proj_meta(animal).rd(layer,day).LickTrace; %Lick signals
        seqEleIDsig{animal,day} = proj_meta(animal).rd(layer,day).StimulusID; %Sequence Element ID signal signals
        seqIDsig{animal,day} = proj_meta(animal).rd(layer,day).Stim; %Sequence Element ID signal signals
        reward{animal,day} = proj_meta(animal).rd(layer,day).RewardTrig; %Sequence Element ID signal signals
        blink{animal,day} = proj_meta(animal).rd(layer,day).blinkR; %Blink signals
        pupilD{animal,day} = proj_meta(animal).rd(layer,day).pupil_diamR; %Pupil diameter signals
    end
end
for animal = 6; %For the animal where we do not have timepoint 1
    for day = 2:8
        for layer = 1:4;
            tempact{layer} = proj_meta(animal).rd(layer,day-1).act;
        end
        act{animal,day} = vertcat(tempact{1:4}); %Cell activity across layers
        airPuff{animal,day} = proj_meta(animal).rd(layer,day-1).AirPuff; %AirPuff signals
        lick{animal,day} = proj_meta(animal).rd(layer,day-1).LickTrace; %Lick signals
        seqEleIDsig{animal,day} = proj_meta(animal).rd(layer,day-1).StimulusID; %Sequence Element ID signal signals
        seqIDsig{animal,day} = proj_meta(animal).rd(layer,day-1).Stim; %Sequence Element ID signal signals
        reward{animal,day} = proj_meta(animal).rd(layer,day-1).RewardTrig; %Sequence Element ID signal signals
        blink{animal,day} = proj_meta(animal).rd(layer,day-1).blinkR; %Blink signals
        pupilD{animal,day} = proj_meta(animal).rd(layer,day-1).pupil_diamR; %Pupil diameter signals
    end
end

%Exception for animal 2 (032) where we can't use the omission data
act{2,7} = [];
airPuff{2,7} = [];
lick{2,7} = [];
seqEleIDsig{2,7} = [];
seqIDsig{2,7} = [];
reward{2,7} = [];
blink{2,7} = [];
pupilD{2,7} = [];

act{2,8} = [];
airPuff{2,8} = [];
lick{2,8} = [];
seqEleIDsig{2,8} = [];
seqIDsig{2,8} = [];
reward{2,8} = [];
blink{2,8} = [];
pupilD{2,8} = [];
%Downsample lick

for day = 1:8
    for animal = 1:6
        binVector = round(linspace(1,length(lick{animal,day}),size(act{animal,day},2)+1));
        for bin = 1:length(binVector)-1;
            Lick{animal,day}(bin) = mean(lick{animal,day}(binVector(bin):binVector(bin+1)));
        end
    end
end