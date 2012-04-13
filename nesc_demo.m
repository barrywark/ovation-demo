%% Connect to the Ovation Database
ctx = NewDataContext('/Users/barry/Documents/MATLAB/data/nesc_demo.connection');
projects = ctx.getProjects();
genera = ctx.getSources('genus');
project = projects(1);
disp(project)

%% From Epoch => Source("genus") => EpochGroups
epoch = ctx.objectWithURI('ovation:///46bbf89b-5595-419a-9ba0-ae23bcc2038a/#5-1003-1-15:1000044');
disp(epoch)
epoch.getResponse('body length').getFloatingPointData

genus = epoch.getEpochGroup().getSource().getParentRoot();
genus.getOwnerProperty('genus-name')

allAstatoreochromisEpochGroups = genus.getAllEpochGroups();
disp(allAstatoreochromisEpochGroups)

%% All anatomy EpochGroups

iterator = ctx.query(editQuery());

body_length = [];
brain_mass = [];
while(iterator.hasNext())
    eg = iterator.next();
    eItr = eg.getEpochsIterable().iterator();
    while(eItr.hasNext())
        epoch = eItr.next();
       r_body_length = epoch.getResponse('body length');
       r_brain_mass = epoch.getResponse('brain mass');
       
       if(~isempty(r_body_length) && ~isempty(r_brain_mass))
          body_length(end+1) = r_body_length.getFloatingPointData(); %#ok<SAGROW>
          brain_mass(end+1) = r_brain_mass.getFloatingPointData();  %#ok<SAGROW>
       end
    end
end

plot(brain_mass, body_length, '.');
xlabel(['Brain mass (' char(r_brain_mass.getUnits()) ')']);
ylabel(['Body length (' char(r_body_length.getUnits()) ')']);
title('Brain mass vs. body length for all anatomy data');

%% Add an analysis record

itr = ctx.query(editQuery());
analysisRecord = project.insertAnalysisRecord('NESCent Demo: Brain length vs. Body mass',...
    itr,...
    'nesc_demo.m',...
    struct2map(struct()),...
    'http://github.com/physion/ovation_demo.git',...
    'c8a0838');
disp(analysisRecord)