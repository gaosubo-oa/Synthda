package com.xoa.util.jieba;

import com.huaban.analysis.jieba.JiebaSegmenter;
import com.huaban.analysis.jieba.WordDictionary;

import java.io.*;
import java.nio.file.*;
import java.util.*;

/*
  结巴分词
 */
public class jieba {

    //使用自定义词库

    static HashSet<String> stopWordsSet;
    static Path sogou;

    //获取字符串中所有 分词  自定义词数
    public Map<String, Integer> getStr(String content,Integer num) throws IOException {
        Map<String, Integer> freqMap = new HashMap();
        if (content == null || content.equals(""))
            return freqMap;

        if (sogou == null) {
            try {
                sogou = FileSystems.getDefault().getPath(getPathStr("sougou.dict") );
            } catch (Exception e) {
                System.err.println("搜狗细胞词库加载失败");
            }
        }
        if(stopWordsSet==null) {
            stopWordsSet=new HashSet();
            try {
                loadStopWords(stopWordsSet, new FileInputStream(getPathStr("stop_words.txt")));
            } catch (IOException e) {
                System.err.println("排除词文件加载失败");
            }
        }
        WordDictionary.getInstance().loadUserDict(sogou);
        JiebaSegmenter segmenter = new JiebaSegmenter();
        List<String> segments = segmenter.sentenceProcess(content);
        for (String segment : segments) {
            if(!stopWordsSet.contains(segment) && segment.length()>1) {
                if (freqMap.containsKey(segment)) {
                    freqMap.put(segment, freqMap.get(segment) + 1);
                } else {
                    freqMap.put(segment, 1);
                }
            }
            if (freqMap.size() >= num) {
                break;
            }
        }
        return freqMap;
    }
    // 100词
    public Map<String, Integer> getStr(String content) throws IOException {
        Map<String, Integer> freqMap = new HashMap();
        if (content == null || content.equals(""))
            return freqMap;

        if (sogou == null) {
            try {
                sogou = FileSystems.getDefault().getPath(getPathStr("sougou.dict") );
            } catch (Exception e) {
                System.err.println("搜狗细胞词库加载失败");
            }
        }
        if(stopWordsSet==null) {
            stopWordsSet=new HashSet();
            try {
                loadStopWords(stopWordsSet, new FileInputStream(getPathStr("stop_words.txt")));
            } catch (IOException e) {
                System.err.println("排除词文件加载失败");
            }
        }
        WordDictionary.getInstance().loadUserDict(sogou);
        JiebaSegmenter segmenter = new JiebaSegmenter();
        List<String> segments = segmenter.sentenceProcess(content);
        for (String segment : segments) {
            if(!stopWordsSet.contains(segment) && segment.length()>1) {
                if (freqMap.containsKey(segment)) {
                    freqMap.put(segment, freqMap.get(segment) + 1);
                } else {
                    freqMap.put(segment, 1);
                }
            }
            if (freqMap.size() >= 100) {
                break;
            }
        }
        return freqMap;
    }
    private  String getPathStr(String fileName){
        String osName = System.getProperty("os.name");
        StringBuffer sb = new StringBuffer();
        String path = this.getClass().getClassLoader().getResource(".").getPath()+ "config" + System.getProperty("file.separator") + "jieba"+ System.getProperty("file.separator")+fileName;
        if (osName.toLowerCase().startsWith("win")) {
            sb.append(path.substring(1));
        }else {
            sb.append(path);
        }
        return sb.toString();
    }

    private void loadStopWords(Set<String> set, InputStream in) throws IOException {
        BufferedReader bufr = null;
        try {
            bufr = new BufferedReader(new InputStreamReader(in));
            String line = null;
            while ((line = bufr.readLine()) != null) {
                set.add(line.trim());
            }
        }finally {
            if (bufr != null) {
                bufr.close();
            }
        }
    }

    //测试
    public static void main(String[] args) throws IOException {

        String content = "神舟十五号载人飞行任务实施在即，值此之际，让我们跟随记者的脚步，一同探寻文昌航天人建造“太空家园”的幕后故事";
        jieba jieba = new jieba();
        Map<String, Integer> getStr = jieba.getStr(content);
        System.out.println(getStr.toString());

    }

}

