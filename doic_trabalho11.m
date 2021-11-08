% Começa por limpar a command line
clc;
clear;
%definindo as variaveis
O1=[0,0,0];
O2=[0,0,0];
O3=[0,0,0];
O4=[0,0,0];
O5=[0,0,0];
V1=[1.00,1.01,1.01];
V2=[1,1,1];
V3=[1.01,1.02,1.02];
V4=[1,1,1];
V5=[1,1,1];

%essas não vão mudar ao longo do programa
O1min=min(O1);
O1max=max(O1);
V1min=min(V1);
V1max=max(V1);
V3min=min(V3);
V3max=max(V3);
O1=(min(O1)+max(O1))/2;
V1=(min(V1)+max(V1))/2;
V3=(min(V3)+max(V3))/2;
%O1=O1(2);
%V1=V1(2);
%V3=V3(2);

%Nosso vetor de variaveis a calcular com tensão e angulo
X=[O2;O3;O4;O5;V2;V4;V5];


%A matriz Z invertida referente a nossaRede Elétrica
G=[0,0,0,0,0;0,0.0312,0.0295,0.0278,0.0126;0,0.0295,0.0646,0.0397,0.018;0,0.0295,0.0397,0.0515,0.0234;0,0.026,0.018,0.0234,0.0379];%já invertida
B=[0,0,0,0,0;0,0.068,0.06,0.052,0.023;0,0.06,0.175,0.089,0.04;0,0.052,0.089,0.126,0.056;0,0.023,0.04,0.056,0.114];%já invertida

Z=G+(B*j);

%Potência especificada ou "chute inicial"
Pi2spec=[-1.05 -1 -0.94];
Pi3spec=[0.9 1.05 1.15];
Pi4spec=[-0.57 -0.5 -0.45];
Pi5spec=[-0.53 -0.5 -0.47];
Qi2spec=[-0.45 -0.4 -0.35];
Qi4spec=[-0.57 -0.2 -0.15];
Qi5spec=[-0.28 -0.25 -0.21];

%Devido a usar numeros fuzzy vamos buscar o menor e maior de cada potencia
%especificada 
SspecMin=[min(Pi2spec),min(Pi3spec),min(Pi4spec),min(Pi5spec),min(Qi2spec),min(Qi4spec),min(Qi5spec)];
Sspec=[Pi2spec(2),Pi3spec(2),Pi4spec(2),Pi5spec(2),Qi2spec(2),Qi4spec(2),Qi5spec(2)];
SspecMax=[max(Pi2spec),max(Pi3spec),max(Pi4spec),max(Pi5spec),max(Qi2spec),max(Qi4spec),max(Qi5spec)];

syms o1 o2 o3 o4 o5 v1 v2 v3 v4 v5;

%começa a iteração (utilizei 3 porque é um numero suficente de iteraçõespara obter resultado interessante)


for i = 0:1:3
% começa por tirar os minimos, maximos e do meio de cada fuzzy 
    O2min=min(X(1));
    O3min=min(X(2));
    O4min=min(X(3));
    O5min=min(X(4));
    V2min=min(X(5));
    V4min=min(X(6));
    V5min=min(X(7));

    %O2=X(1,2);
    %O3=X(2,2);
    %O4=X(3,2);
    %O5=X(4,2);
    %V2=X(5,2);
    %V4=X(6,2);
    %V5=X(7,2);
    
    O2=(min(X(1))+max(X(1)))/2;
    O3=(min(X(2))+max(X(2)))/2;
    O4=(min(X(3))+max(X(3)))/2;
    O5=(min(X(4))+max(X(4)))/2;
    V2=(min(X(5))+max(X(5)))/2;
    V4=(min(X(6))+max(X(6)))/2;
    V5=(min(X(7))+max(X(7)))/2;

    O2max=max(X(1));
    O3max=max(X(2));
    O4max=max(X(3));
    O5max=max(X(4));
    V2max=max(X(5));
    V4max=max(X(6));
    V5max=max(X(7));

    %minimo
    Pi2min=V2min*(V1min*((G(2,1)*cos(O1min-O2min))+(B(2,1)*sin(O1min-O2min)))+V3min*((G(2,3)*cos(O3min-O2min))+(B(2,3)*sin(O3min-O2min)))+V4min*((G(2,4)*cos(O4min-O2min))+(B(2,4)*sin(O4min-O2min))));
    Pi3min=V3min*(V2min*((G(3,2)*cos(O2min-O3min))+(B(3,2)*sin(O2min-O3min)))+V4min*((G(3,4)*cos(O4min-O3min))+(B(3,4)*sin(O4min-O3min))));
    Pi4min=V4min*(V2min*((G(4,2)*cos(O2min-O4min))+(B(4,2)*sin(O2min-O4min)))+V3min*((G(4,3)*cos(O3min-O4min))+(B(4,3)*sin(O3min-O4min)))+V5min*((G(4,5)*cos(O5min-O4min))+(B(4,5)*sin(O5min-O4min))));
    Pi5min=V5min*(V1min*((G(5,1)*cos(O1min-O5min))+(B(5,1)*sin(O1min-O5min)))+V4min*((G(5,4)*cos(O3min-O5min))+(B(5,4)*sin(O4min-O5min))));
    Qi2min=V2min*(V1min*((G(2,1)*sin(O1min-O2min))+(B(2,1)*cos(O1min-O2min)))+V3min*((G(2,3)*sin(O3min-O2min))+(B(2,3)*cos(O3min-O2min)))+V4min*((G(2,4)*sin(O4min-O2min))+(B(2,4)*cos(O4min-O2min))));
    Qi4min=V4min*(V2min*((G(4,3)*sin(O1min-O4min))+(B(4,2)*cos(O2min-O4min)))+V3min*((G(4,3)*sin(O3min-O4min))+(B(4,3)*cos(O3min-O4min)))+V5min*((G(4,5)*sin(O4min-O4min))+(B(4,5)*cos(O5min-O4min))));
    Qi5min=V5min*(V1min*((G(5,1)*sin(O1min-O5min))+(B(5,1)*cos(O1min-O5min)))+V4min*((G(5,4)*sin(O4min-O5min))+(B(5,4)*cos(O4min-O5min))));
    Smin=[Pi2min,Pi3min,Pi4min,Pi5min,Qi2min,Qi4min,Qi5min];
    fxmin=SspecMin+Smin;
    fxmin=transpose(fxmin);

    %Do meio
    Pi2=V2*(V1*((G(2,1)*cos(O1-O2))+(B(2,1)*sin(O1-O2)))+V3*((G(2,3)*cos(O3-O2))+(B(2,3)*sin(O3-O2)))+V4*((G(2,4)*cos(O4-O2))+(B(2,4)*sin(O4-O2))));
    Pi3=V3*(V2*((G(3,2)*cos(O2-O3))+(B(3,2)*sin(O2-O3)))+V4*((G(3,4)*cos(O4-O3))+(B(3,4)*sin(O4-O3))));
    Pi4=V4*(V2*((G(4,2)*cos(O2-O4))+(B(4,2)*sin(O2-O4)))+V3*((G(4,3)*cos(O3-O4))+(B(4,3)*sin(O3-O4)))+V5*((G(4,5)*cos(O5-O4))+(B(4,5)*sin(O5-O4))));
    Pi5=V5*(V1*((G(5,1)*cos(O1-O5))+(B(5,1)*sin(O1-O5)))+V4*((G(5,4)*cos(O3-O5))+(B(5,4)*sin(O4-O5))));
    Qi2=V2*(V1*((G(2,1)*sin(O1-O2))+(B(2,1)*cos(O1-O2)))+V3*((G(2,3)*sin(O3-O2))+(B(2,3)*cos(O3-O2)))+V4*((G(2,4)*sin(O4-O2))+(B(2,4)*cos(O4-O2))));
    Qi4=V4*(V2*((G(4,3)*sin(O1-O4))+(B(4,2)*cos(O2-O4)))+V3*((G(4,3)*sin(O3-O4))+(B(4,3)*cos(O3-O4)))+V5*((G(4,5)*sin(O4-O4))+(B(4,5)*cos(O5-O4))));
    Qi5=V5*(V1*((G(5,1)*sin(O1-O5))+(B(5,1)*cos(O1-O5)))+V4*((G(5,4)*sin(O4-O5))+(B(5,4)*cos(O4-O5))));
    S=[Pi2,Pi3,Pi4,Pi5,Qi2,Qi4,Qi5];
    fx=Sspec+S;
    fx=transpose(fx);

    %maximo
    Pi2max=V2max*(V1max*((G(2,1)*cos(O1max-O2max))+(B(2,1)*sin(O1max-O2max)))+V3max*((G(2,3)*cos(O3max-O2max))+(B(2,3)*sin(O3max-O2max)))+V4max*((G(2,4)*cos(O4max-O2max))+(B(2,4)*sin(O4max-O2max))));
    Pi3max=V3max*(V2max*((G(3,2)*cos(O2max-O3max))+(B(3,2)*sin(O2max-O3max)))+V4max*((G(3,4)*cos(O4max-O3max))+(B(3,4)*sin(O4max-O3max))));
    Pi4max=V4max*(V2max*((G(4,2)*cos(O2max-O4max))+(B(4,2)*sin(O2max-O4max)))+V3max*((G(4,3)*cos(O3max-O4max))+(B(4,3)*sin(O3max-O4max)))+V5max*((G(4,5)*cos(O5max-O4max))+(B(4,5)*sin(O5max-O4max))));
    Pi5max=V5max*(V1max*((G(5,1)*cos(O1max-O5max))+(B(5,1)*sin(O1max-O5max)))+V4max*((G(5,4)*cos(O3max-O5max))+(B(5,4)*sin(O4max-O5max))));
    Qi2max=V2max*(V1max*((G(2,1)*sin(O1max-O2max))+(B(2,1)*cos(O1max-O2max)))+V3max*((G(2,3)*sin(O3max-O2max))+(B(2,3)*cos(O3max-O2max)))+V4max*((G(2,4)*sin(O4max-O2max))+(B(2,4)*cos(O4max-O2max))));
    Qi4max=V4max*(V2max*((G(4,3)*sin(O1max-O4max))+(B(4,2)*cos(O2max-O4max)))+V3max*((G(4,3)*sin(O3max-O4max))+(B(4,3)*cos(O3max-O4max)))+V5max*((G(4,5)*sin(O4max-O4max))+(B(4,5)*cos(O5max-O4max))));
    Qi5max=V5max*(V1max*((G(5,1)*sin(O1max-O5max))+(B(5,1)*cos(O1max-O5max)))+V4max*((G(5,4)*sin(O4max-O5max))+(B(5,4)*cos(O4max-O5max))));
    Smax=[Pi2max,Pi3max,Pi4max,Pi5max,Qi2max,Qi4max,Qi5max];
    fxmax=SspecMax+Smax;
    fxmax=transpose(fxmax);


    %
    % Parte do Jacobiano
    %
    if i==0
        Pi2x=v2*(v1*((G(2,1)*cos(o1-o2))+(B(2,1)*sin(o1-o2)))+v3*((G(2,3)*cos(o3-o2))+(B(2,3)*sin(o3-o2)))+v4*((G(2,4)*cos(o4-o2))+(B(2,4)*sin(o4-o2))));
        Pi3x=v3*(v2*((G(3,2)*cos(o2-o3))+(B(3,2)*sin(o2-o3)))+v4*((G(3,4)*cos(o4-o3))+(B(3,4)*sin(o4-o3))));
        Pi4x=v4*(v2*((G(4,2)*cos(o2-o4))+(B(4,2)*sin(o2-o4)))+v3*((G(4,3)*cos(o3-o4))+(B(4,3)*sin(o3-o4)))+v5*((G(4,5)*cos(o5-o4))+(B(4,5)*sin(o5-o4))));
        Pi5x=v5*(v1*((G(5,1)*cos(o1-o5))+(B(5,1)*sin(o1-o5)))+v4*((G(5,4)*cos(o3-o5))+(B(5,4)*sin(o4-o5))));
        Qi2x=v2*(v1*((G(2,1)*sin(o1-o2))+(B(2,1)*cos(o1-o2)))+v3*((G(2,3)*sin(o3-o2))+(B(2,3)*cos(o3-o2)))+v4*((G(2,4)*sin(o4-o2))+(B(2,4)*cos(o4-o2))));
        Qi4x=v4*(v2*((G(4,3)*sin(o1-o4))+(B(4,2)*cos(o2-o4)))+v3*((G(4,3)*sin(o3-o4))+(B(4,3)*cos(o3-o4)))+v5*((G(4,5)*sin(o4-o4))+(B(4,5)*cos(o5-o4))));
        Qi5x=v5*(v1*((G(5,1)*sin(o1-o5))+(B(5,1)*cos(o1-o5)))+v4*((G(5,4)*sin(o4-o5))+(B(5,4)*cos(o4-o5))));
        Sx=[Pi2x,Pi3x,Pi4x,Pi5x,Qi2x,Qi4x,Qi5x];

        Hx=jacobian(Sx,[o2,o3,o4,o5,v2,v4,v5]);
    end
    
    Hmin=subs(Hx,{o1,o2,o3,o4,o5,v1,v2,v3,v4,v5},{O1min,O2min,O3min,O4min,O5min,V1min,V2min,V3min,V4min,V5min});
    H=subs(Hx,{o1,o2,o3,o4,o5,v1,v2,v3,v4,v5},{O1,O2,O3,O4,O5,V1,V2,V3,V4,V5});
    Hmax=subs(Hx,{o1,o2,o3,o4,o5,v1,v2,v3,v4,v5},{O1max,O2max,O3max,O4max,O5max,V1max,V2max,V3max,V4max,V5max});
    
    Hmin=vpa(inv(Hmin),5);
    H=vpa(inv(H),5);
    Hmax=vpa(inv(Hmax),5);
    
    Ymin=Hmin*fxmin;
    Y=H*fx;
    Ymax=Hmax*fxmax;
    
    X=[Ymin,Y,Ymax];
   
    
    fprintf('Estamos na Iteracao: %d\n',i)
    
end
