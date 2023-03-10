var students = ["Ben", "Ivy", "Jordell", "Maxime"]
if let i = students.firstIndex(of: "Maxime") {
    print(i)
    students[i] = "Max"
}
print(students)

if let i = students.index(of: "Max") {
    print(i)
    students[i] = "Maxime"
}
print(students)

