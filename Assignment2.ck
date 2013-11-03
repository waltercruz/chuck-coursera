SinOsc sn => dac;

TriOsc tr => Pan2 p => dac;
SawOsc sw => Pan2 p2 => dac;
1::second => dur T;
[ 50, 52, 53, 55, 57, 59, 60, 62 ] @=> int dorian[];
[ 50, 50, 50, 50] @=> int phrase1[];
[ 1.0 , 0.2,0.4, 0.6] @=> float volumes1[];
[ 62, 60, 59, 57] @=> int phrase2[];
[ 0, 12, 24 ] @=> int octave[];

0.2 => sw.gain;

now + 30::second => time later;
while( now < later  )
{
    for( 0 => int i; i < phrase1.cap(); i++ )
    {
        Std.mtof(phrase1[i]) => sn.freq;
        volumes1[i] => sn.gain;
        
        
        Std.mtof(phrase2[i] +12 ) => tr.freq;
        .25::T => now; 
        dorian[ Math.random2(0,7) ] +  octave[Math.random2(0,2)]=> float freq;
        Std.mtof(freq) => sw.freq;
        Math.sin( now / 1::second * 2 * pi ) => p.pan;
    }
}