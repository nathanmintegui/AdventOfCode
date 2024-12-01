def part_one():
    leftList = []
    rightList = []
    sum = 0

    with open("input.txt", 'r') as file:
        for line in file:
            parts = line.strip().split(" ")
            left = int(parts[0])
            right = int(parts[3])

            leftList.append(left)
            rightList.append(right)

        leftList.sort()
        rightList.sort()

        for left, right in zip(leftList, rightList):
            sum += abs(left - right)

        return sum


def part_two():
    map = {}
    sum = 0

    with open("input.txt", 'r') as file:
        for line in file:
            parts = line.strip().split(" ")
            k = parts[3]

            if k in map:
                map[k] += 1
                continue

            map[k] = 1

        # Reset file pointer to start reading again
        file.seek(0)

        for line in file:
            parts = line.strip().split(" ")
            left = str(parts[0])

            if left in map:
                sum += (int(left) * map[str(left)])

        return sum


if __name__ == "__main__":
    print(part_one())
    print(part_two())
