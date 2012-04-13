%% Connect to the Ovation Database
ctx = NewDataContext('/Users/barry/Documents/MATLAB/data/nesc_demo.connection')

%% Add an analysis record
project.insertAnalysisRecord('NESCent Demo',...
    epochs,...
    'NESCDemo.m',...
    'git://github.com/physion/ovation_demo.git',...
    