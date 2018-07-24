# VMAF

Dockerfile for https://github.com/Netflix/vmaf

## Usage

Prepare two video files for analysis, e.g.:

```
docker run --rm -v $(pwd):/input jrottenberg/ffmpeg -i /input/file1.mkv -c:v rawvideo -pix_fmt yuv420p -ss 00:01:00.0 -t 00:01:00.0 /input/file1.yuv

docker run --rm -v $(pwd):/input jrottenberg/ffmpeg -i /input/file2.mkv -c:v rawvideo -pix_fmt yuv420p -ss 00:01:00.0 -t 00:01:00.0 /input/file2.yuv
```

Then run vmaf:

```
docker run --rm -v $(pwd):/input shamelesscookie/vmaf run_vmaf yuv420p 1920 1080 /input/file1.yuv /input/file2.yuv --out-fmt json
```

Analysis will take some time. 1 minute of 1080p30 is approx. 10 minutes to analyze on average CPU.

Output will resemble:

```
"aggregate": {
        "VMAF_feature_adm2_score": 0.98901587685981363, 
        "VMAF_feature_motion2_score": 0.60910596664813788, 
        "VMAF_feature_vif_scale0_score": 0.74128549591109139, 
        "VMAF_feature_vif_scale1_score": 0.96923675333800652, 
        "VMAF_feature_vif_scale2_score": 0.98526048882444595, 
        "VMAF_feature_vif_scale3_score": 0.99172407711438593, 
        "VMAF_score": 94.413905215994887, 
        "method": "mean"
    }
```