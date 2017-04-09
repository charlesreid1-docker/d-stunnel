PORT=443
rsync:
	./build_rsync.sh $(PORT)
	./run_rsync.sh $(PORT)
	echo "Run ./open_fw.sh $(PORT)"
ssh:
	./build_ssh.sh $(PORT)
	./run_ssh.sh $(PORT)
	echo "Run ./open_fw.sh $(PORT)"
