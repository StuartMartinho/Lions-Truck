public class L_GuidUtility {

    private static String availableChars = '0123456789abcdef';

    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used to generate a random GUID value.
    **************************************************************************************************/
    public static String newGuid() {

        String returnValue = '';
        Integer nextByte = 0;

        for (Integer i=0; i<16; i++) {

            if (i==4 || i==6 || i==8 || i==10) 
                returnValue += '-';

            nextByte = (Math.round(Math.random() * 255)-128) & 255;

            if (i==6) {
                nextByte = nextByte & 15;
                nextByte = nextByte | (4 << 4);
            }

            if (i==8) {
                nextByte = nextByte & 63;
                nextByte = nextByte | 128;
            }

            returnValue += getCharAtIndex(availableChars, nextByte >> 4);
            returnValue += getCharAtIndex(availableChars, nextByte & 15);
        }

        return returnValue;
    }

    private static String getCharAtIndex(String str, Integer index) {

        if (str == null) return null;

        if (str.length() <= 0) return str;    

        if (index == str.length()) return null;    

        return str.substring(index, index+1);
    }

}