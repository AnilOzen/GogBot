Person[] brainjars = new Person[5];
String[] names = {"persona1" ,"persona2", "persona3", "persona4", "persona5" };
String[] emotionNames = {"Funny", "Happy", "Neutral", "Sad", "Angry"};
Emotion[] emotions = new Emotion[5];

void setup()
{
  //initializing each person
  for (int i=0; i<5; i++)
  {
    emotions[i] = new Emotion(emotionNames[i]);
    brainjars[i] = new Person(emotions[i], names[i]);  
  }
  
 
  
}

void draw()
{

}