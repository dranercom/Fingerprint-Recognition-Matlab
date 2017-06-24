fprintf(['>> Clearing database... ']);
delete database.mat

person = struct('Name', [], 'Age', [], 'FID1', [], 'FID2', []);
person = struct2table(person);

minutiae = struct('ID', [], 'X', [], 'Y', [], 'Type', [], 'Angle', [],'S1', [], 'S2', []);
minutiae = struct2table(minutiae);

save database person minutiae

fprintf(['done!\n']);