void setup() {
  // put your setup code here, to run once:
  pinMode(12, OUTPUT);
  pinMode(13, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  digitalWrite(12, HIGH);
  digitalWrite(13, HIGH);
  int jump = digitalRead(12);
  int start = digitalRead(13);
  Serial.print(jump);
  Serial.print(", ");
  Serial.print(start);
  Serial.print("\n");
}
