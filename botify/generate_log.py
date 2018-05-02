import sys
import re


uuid4hex = re.compile('[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}', re.I)
uuid_dict = {}


def main():
    try:
        if len(sys.argv) >= 4:
            outlog = sys.argv[3]
            refers = sys.argv[2]
            router = sys.argv[1]
        else:
            return 0
    except Exception as ex:
        print(ex.message)
        return 1

    with open(refers) as refile:
        for line in refile:
            req_id = re.findall("\[(.*?)\]", line)

            if len(req_id) > 2 and uuid4hex.match(req_id[1]):
                if req_id[1] in uuid_dict:
                    pass
                else:
                    if len(req_id) > 3:
                        uuid_dict[req_id[1]] = ' user-agent="{}" referer="{}"'.format(req_id[2], req_id[3])
                    else:
                        uuid_dict[req_id[1]] = ' user-agent="{}"'.format(req_id[2])

    bunchsize = 1000000     # Experiment with different sizes
    bunch = []
    with open(router) as infile, open(outlog, "w") as outfile:
        for line in infile:

            uid = uuid4hex.search(line)
            if uid and uid.group() in uuid_dict:
                bunch.append(line.rstrip() + uuid_dict[uid.group()] + "\n")
            else:
                bunch.append(line)

            if len(bunch) == bunchsize:
                outfile.writelines(bunch)
        outfile.writelines(bunch)

    print("finish with generating the logs")
    print(len(uuid_dict.keys()))


if __name__ == '__main__':
    main()
