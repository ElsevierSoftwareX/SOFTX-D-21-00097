function [BW,index_removed_voxels] = Function_clean_voxelconnection(BW)

sz = size(BW);

% Initialise the loop parameters
number_of_change = 1e9;
index_removed_voxels=[];

while number_of_change>0
    
    % Initialisation
    to_be_removed = zeros(sz);
    
    %% CLEANING PROCESS: 1/4: IDENTIFY ALL CONNECTIONS (26 POSSIBILITIES) AROUND EACH VOXEL
    
    % Could be use to get sp from all directions: ~isotropic test
    
    % Test will be done with elemet by element Matlab calculation
    
    % Some of the test are redondant for the step 2/5 and 3/5 and then are put in commentary
    
    % % 1 Direction
    
    % 1/26: x+
    connection_x_plus = zeros(sz);
    connection_x_plus(1:end-1,:,:) = BW(1:end-1,:,:).*BW(2:end,:,:);
    
    % 2/26: x-
    connection_x_minus = zeros(sz);
    connection_x_minus(2:end,:,:) = BW(2:end,:,:).*BW(1:end-1,:,:);
    
    % 3/26: y+
    connection_y_plus = zeros(sz);
    connection_y_plus(:,1:end-1,:) = BW(:,1:end-1,:).*BW(:,2:end,:);
    
    % 4/26: y-
    connection_y_minus = zeros(sz);
    connection_y_minus(:,2:end,:) = BW(:,2:end,:).*BW(:,1:end-1,:);
    
    % 5/26: z+
    connection_z_plus = zeros(sz);
    connection_z_plus(:,:,1:end-1) = BW(:,:,1:end-1).*BW(:,:,2:end);
    
    % 6/26: z-
    connection_z_minus = zeros(sz);
    connection_z_minus(:,:,2:end) = BW(:,:,2:end).*BW(:,:,1:end-1);
    
    % % 2 Directions
    
    % 7/26: x+ y+
    connection_x_plus_y_plus = zeros(sz);
    connection_x_plus_y_plus(1:end-1,1:end-1,:) = BW(1:end-1,1:end-1,:).*BW(2:end,2:end,:);
    
    % 8/26: x+ y-
    connection_x_plus_y_minus = zeros(sz);
    connection_x_plus_y_minus(1:end-1,2:end,:) = BW(1:end-1,2:end,:).*BW(2:end,1:end-1,:);
    
    % 9/26: x- y+
    connection_x_minus_y_plus = zeros(sz);
    connection_x_minus_y_plus(2:end,1:end-1,:) = BW(2:end,1:end-1,:).*BW(1:end-1,2:end,:);
    
    % 10/26: x- y-
    % connection_x_minus_y_minus = zeros(sz);
    % connection_x_minus_y_minus(2:end,2:end,:) = BW(2:end,2:end,:).*BW(1:end-1,1:end-1,:);
    
    % 11/26: x+ z+
    connection_x_plus_z_plus = zeros(sz);
    connection_x_plus_z_plus(1:end-1,:,1:end-1) = BW(1:end-1,:,1:end-1).*BW(2:end,:,2:end);
    
    % 12/26: x+ z-
    connection_x_plus_z_minus = zeros(sz);
    connection_x_plus_z_minus(1:end-1,:,2:end) = BW(1:end-1,:,2:end).*BW(2:end,:,1:end-1);
    
    % 13/26: x- z+
    connection_x_minus_z_plus = zeros(sz);
    connection_x_minus_z_plus(2:end,:,1:end-1) = BW(2:end,:,1:end-1).*BW(1:end-1,:,2:end);
    
    % 14/26: x- z-
    % connection_x_minus_z_minus = zeros(sz);
    % connection_x_minus_z_minus(2:end,:,2:end) = BW(2:end,:,2:end).*BW(1:end-1,:,1:end-1);
    
    % 15/26: y+ z+
    connection_y_plus_z_plus = zeros(sz);
    connection_y_plus_z_plus(:,1:end-1,1:end-1) = BW(:,1:end-1,1:end-1).*BW(:,2:end,2:end);
    
    % 16/26: y+ z-
    connection_y_plus_z_minus = zeros(sz);
    connection_y_plus_z_minus(:,1:end-1,2:end) = BW(:,1:end-1,2:end).*BW(:,2:end,1:end-1);
    
    % 17/26: y- z+
    connection_y_minus_z_plus = zeros(sz);
    connection_y_minus_z_plus(:,2:end,1:end-1) = BW(:,2:end,1:end-1).*BW(:,1:end-1,2:end);
    
    % 18/26: y- z-
    % connection_y_minus_z_minus = zeros(sz);
    % connection_y_minus_z_minus(:,2:end,2:end) = BW(:,2:end,2:end).*BW(:,1:end-1,1:end-1);
    
    % % 3 Directions
    
    % 19/26: x+ y+ z+
    connection_x_plus_y_plus_z_plus = zeros(sz);
    connection_x_plus_y_plus_z_plus(1:end-1,1:end-1,1:end-1) = BW(1:end-1,1:end-1,1:end-1).*BW(2:end,2:end,2:end);
    
    % 20/26: x+ y+ z-
    connection_x_plus_y_plus_z_minus = zeros(sz);
    connection_x_plus_y_plus_z_minus(1:end-1,1:end-1,2:end) = BW(1:end-1,1:end-1,2:end).*BW(2:end,2:end,1:end-1);
    
    % 21/26: x+ y- z+
    connection_x_plus_y_minus_z_plus = zeros(sz);
    connection_x_plus_y_minus_z_plus(1:end-1,2:end,1:end-1) = BW(1:end-1,2:end,1:end-1).*BW(2:end,1:end-1,2:end);
    
    % 22/26: x+ y- z-
    % connection_x_plus_y_minus_z_minus = zeros(sz);
    % connection_x_plus_y_minus_z_minus(1:end-1,2:end,2:end) = BW(1:end-1,2:end,2:end).*BW(2:end,1:end-1,1:end-1);
    
    % 23/26: x- y+ z+
    connection_x_minus_y_plus_z_plus = zeros(sz);
    connection_x_minus_y_plus_z_plus(2:end,1:end-1,1:end-1) = BW(2:end,1:end-1,1:end-1).*BW(1:end-1,2:end,2:end);
    
    % 24/26: x- y+ z-
    % connection_x_minus_y_plus_z_minus = zeros(sz);
    % connection_x_minus_y_plus_z_minus(2:end,1:end-1,2:end) = BW(2:end,1:end-1,2:end).*BW(1:end-1,2:end,1:end-1);
    
    % 25/26: x- y- z+
    % connection_x_minus_y_minus_z_plus = zeros(sz);
    % connection_x_minus_y_minus_z_plus(2:end,2:end,1:end-1) = BW(2:end,2:end,1:end-1).*BW(1:end-1,1:end-1,2:end);
    
    % 26/26: x- y- z-
    % connection_x_minus_y_minus_z_minus = zeros(sz);
    % connection_x_minus_y_minus_z_minus(2:end,2:end,2:end) = BW(2:end,2:end,2:end).*BW(1:end-1,1:end-1,1:end-1);
    
    
    
    %% CLEANING PROCESS: 2/4: DETECT VOXELS THAT TOUCH EACH OTHER WITH ONLY ONE NODE
    
    % There are 8 nodes to test.
    % Test will be done with elemet by element Matlab calculation
    % Since, it is symmetric to test +++ and ---, only 4 configurations are tested
    
    % 1/8 (2/8): x+ y+ z+ (x- y- z-)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = (connection_x_plus.*connection_x_plus_y_plus)+(connection_y_plus.*connection_x_plus_y_plus)...
        +(connection_x_plus.*connection_x_plus_z_plus)+(connection_z_plus.*connection_x_plus_z_plus)...
        +(connection_y_plus.*connection_y_plus_z_plus)+(connection_z_plus.*connection_y_plus_z_plus);
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_x_plus_y_plus_z_plus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    % 3/8 (4/8): x+ y+ z- (x- y- z+)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = (connection_x_plus.*connection_x_plus_y_plus)+(connection_y_plus.*connection_x_plus_y_plus)...
        +(connection_x_plus.*connection_x_plus_z_minus)+(connection_z_minus.*connection_x_plus_z_minus)...
        +(connection_y_plus.*connection_y_plus_z_minus)+(connection_z_minus.*connection_y_plus_z_minus);
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_x_plus_y_plus_z_minus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    % 5/8 (6/8): x+ y- z+ (x- y+ z-)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = (connection_x_plus.*connection_x_plus_y_minus)+(connection_y_minus.*connection_x_plus_y_minus)...
        +(connection_x_plus.*connection_x_plus_z_plus)+(connection_z_plus.*connection_x_plus_z_plus)...
        +(connection_y_minus.*connection_y_minus_z_plus)+(connection_z_plus.*connection_y_minus_z_plus);
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_x_plus_y_minus_z_plus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    % 7/8 (8/8): x- y+ z+ (x+ y- z-)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = (connection_x_minus.*connection_x_minus_y_plus)+(connection_y_plus.*connection_x_minus_y_plus)...
        +(connection_x_minus.*connection_x_minus_z_plus)+(connection_z_plus.*connection_x_minus_z_plus)...
        +(connection_y_plus.*connection_y_plus_z_plus)+(connection_z_plus.*connection_y_plus_z_plus);
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_x_minus_y_plus_z_plus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    
    %% CLEANING PROCESS: 3/4: DETECT VOXELS THAT TOUCH EACH OTHER WITH ONLY ONE LINE
    
    % There are 12 lines to test.
    % Test will be done with elemet by element Matlab calculation
    % Since, it is symmetric to test ++ and --, only 6 configurations are tested
    
    % Notation
    % 1: sucess
    % 0: to be removed
    %-1: complementary phase
    
    % 1/12 (2/12) : x+ y+ (x- y-)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = connection_x_plus+connection_y_plus;
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_x_plus_y_plus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    % 3/12 (4/12) : x+ y- (x- y+)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = connection_x_plus+connection_y_minus;
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_x_plus_y_minus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    % 5/12 (6/12) : x+ z+ (x- z-)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = connection_x_plus+connection_z_plus;
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_x_plus_z_plus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    % 7/12 (8/12) : x+ z- (x- z+)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = connection_x_plus+connection_z_minus;
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_x_plus_z_minus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    % 9/12 (10/12) : y+ z+ (y- z-)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = connection_y_plus+connection_z_plus;
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_y_plus_z_plus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    % 11/12 (12/12) : y+ z- (y- z+)
    % Check neighbour
    Neighbour_check = zeros(sz);
    Neighbour_check = connection_y_plus+connection_z_minus;
    Neighbour_check(Neighbour_check==0)=-1;
    Neighbour_check(Neighbour_check~=-1)=0;
    Neighbour_check(BW==0)=0;
    Neighbour_check(Neighbour_check==-1)=1;
    % Check bad connection
    test_ = zeros(sz);
    test_ = connection_y_plus_z_minus.*Neighbour_check;
    test_(BW==0)=0;
    % Voxels that must be removed are stored
    to_be_removed(test_==1)=1;
    
    
    %% CLEANING PROCESS: 4/4: REMOVE DETECTED VOXELS
    
    % Number of change (number of voxel that are removed)
    number_of_change = sum(sum(sum(to_be_removed==1)));
    
    % Remove these voxels
    BW(to_be_removed==1)=0;
        
    % Keep a trace of them
    index_removed_voxels = [index_removed_voxels;find(to_be_removed==1)];
            
    
end


end

