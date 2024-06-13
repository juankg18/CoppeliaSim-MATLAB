clear all;
disp('Program started');
currentJoints=zeros(1,6);
sim=remApi('remoteApi');
sim.simxFinish(-1);
JointNames={'UR5_joint1','UR5_joint2','UR5_joint3','UR5_joint4','UR5_joint5','UR5_joint6'};
res1=1;res2=1;res3=1;
clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5);
if (clientID>-1)
    disp('Connected to remote API server');
    res1=sim.simxStartSimulation(clientID,sim.simx_opmode_oneshot_wait);
    for i=1:6
        [res1,sixJoints(i)]=sim.simxGetObjectHandle(clientID,JointNames{i},sim.simx_opmode_oneshot_wait);
    end
    if(sim.simxGetConnectionId(clientID)~=-1)
        Joints=[pi/2 0 0 -pi/2 0 0];
        sim.simxPauseCommunication(clientID,0);
        res=sim.simxSetJointTargetPosition(clientID,sixJoints(1),Joints(1),sim.simx_opmode_oneshot);
        res=sim.simxSetJointTargetPosition(clientID,sixJoints(2),Joints(2),sim.simx_opmode_oneshot);
        res=sim.simxSetJointTargetPosition(clientID,sixJoints(3),Joints(3),sim.simx_opmode_oneshot);
        res=sim.simxSetJointTargetPosition(clientID,sixJoints(4),Joints(4),sim.simx_opmode_oneshot);
        res=sim.simxSetJointTargetPosition(clientID,sixJoints(5),Joints(5),sim.simx_opmode_oneshot);
        res=sim.simxSetJointTargetPosition(clientID,sixJoints(6),Joints(6),sim.simx_opmode_oneshot);
        sim.simxPauseCommunication(clientID,1);
        pause(.02)
        sim.simxPauseCommunication(clientID,0);
    end
    pause(2);
    sim.simxStopSimulation(clientID,sim.simx_opmode_oneshot);
end